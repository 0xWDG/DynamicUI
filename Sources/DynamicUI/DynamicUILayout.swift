//
//  DynamicUILayout.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import Foundation

/// A versioned collection of components rendered by ``DynamicUI``.
public struct DynamicUILayout: Codable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case schemaVersion
        case components
    }

    /// The schema version supported by this release.
    public static let currentSchemaVersion = 1

    /// The version used to validate this layout.
    public let schemaVersion: Int

    /// The root components in rendering order.
    public let components: [DynamicUIComponent]

    /// Creates a versioned layout.
    public init(
        schemaVersion: Int = DynamicUILayout.currentSchemaVersion,
        components: [DynamicUIComponent]
    ) throws {
        self.schemaVersion = schemaVersion
        self.components = components
        try validate()
    }

    /// Decodes and validates a versioned layout envelope or a legacy component array.
    public init(json: Data) throws {
        self = try DynamicUILayoutDecoder.decodeLayout(from: json)
    }

    /// Decodes and validates a versioned layout envelope or a legacy component array.
    public init(json: String) throws {
        try self.init(json: Data(json.utf8))
    }

    /// Decodes and validates a versioned layout envelope.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let schemaVersion = try container.decode(Int.self, forKey: .schemaVersion)
        let components = try container.decode(
            [DynamicUIComponentEntry].self,
            forKey: .components
        ).compactMap(\.component)
        try self.init(schemaVersion: schemaVersion, components: components)
    }

    /// Encodes the layout as a versioned envelope.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(schemaVersion, forKey: .schemaVersion)
        try container.encode(components, forKey: .components)
    }

    /// Validates schema compatibility and component identifiers and conditions.
    public func validate() throws {
        guard schemaVersion == Self.currentSchemaVersion else {
            throw DynamicUISchemaError.unsupportedSchemaVersion(
                found: schemaVersion,
                supported: Self.currentSchemaVersion
            )
        }

        var identifiers = Set<String>()
        try Self.validate(components, path: "components", identifiers: &identifiers)
    }

    private static func validate(
        _ components: [DynamicUIComponent],
        path: String,
        identifiers: inout Set<String>
    ) throws {
        for (index, component) in components.enumerated() {
            let componentPath = "\(path)[\(index)]"
            guard !component.type.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                throw DynamicUISchemaError.emptyComponentType(path: componentPath)
            }

            if let identifier = component.identifier {
                guard !identifier.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    throw DynamicUISchemaError.emptyIdentifier(path: componentPath)
                }
                guard identifiers.insert(identifier).inserted else {
                    throw DynamicUISchemaError.duplicateIdentifier(identifier, path: componentPath)
                }
            }

            if let condition = component.condition {
                let reference = condition.trimmingCharacters(in: .whitespacesAndNewlines)
                let identifier = reference.dropFirst().trimmingCharacters(in: .whitespacesAndNewlines)
                guard reference.hasPrefix("$"), !identifier.isEmpty else {
                    throw DynamicUISchemaError.invalidCondition(condition, path: componentPath)
                }
            }

            try validate(
                component.children ?? [],
                path: "\(componentPath).children",
                identifiers: &identifiers
            )
        }
    }
}

/// Validation failures for versioned DynamicUI layouts.
public enum DynamicUISchemaError: Error, Equatable, LocalizedError {
    case unsupportedSchemaVersion(found: Int, supported: Int)
    case emptyComponentType(path: String)
    case emptyIdentifier(path: String)
    case duplicateIdentifier(String, path: String)
    case invalidCondition(String, path: String)

    public var errorDescription: String? {
        switch self {
        case .unsupportedSchemaVersion(let found, let supported):
            return "Unsupported DynamicUI schema version \(found). This release supports version \(supported)."
        case .emptyComponentType(let path):
            return "The component at \(path) has an empty type."
        case .emptyIdentifier(let path):
            return "The component at \(path) has an empty identifier."
        case .duplicateIdentifier(let identifier, let path):
            return "The identifier '\(identifier)' is duplicated at \(path)."
        case .invalidCondition(let condition, let path):
            return "The condition '\(condition)' at \(path) must reference an identifier such as '$enabled'."
        }
    }
}

extension DynamicUILayoutDecoder {
    static func decodeLayout(from data: Data) throws -> DynamicUILayout {
        let decoder = JSONDecoder()

        if try JSONSerialization.jsonObject(with: data) is [String: Any] {
            return try decoder.decode(DynamicUILayout.self, from: data)
        }

        let components = try decoder
            .decode([DynamicUIComponentEntry].self, from: data)
            .compactMap(\.component)
        return try DynamicUILayout(components: components)
    }
}
