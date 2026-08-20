//
//  DynamicUIComponent.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 16/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// This struct constructs a UI Component from JSON.
public struct DynamicUIComponent: Codable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case type
        case title
        case text
        case condition = "if"
        case identifier
        case eventHandler
        case defaultValue
        case modifiers
        case parameters
        case url
        case children
        case minimum
        case minimumValue
        case maximum
        case maximumValue
        case disabled
        case state
    }

    /// Type of component
    ///
    /// This is the evaqulent of a SwiftUI View
    public let type: String

    /// Title/Label of component
    public let title: String?

    /// Text within component (if any)
    public let text: String?

    /// Identifier expression that determines whether the component is rendered.
    public let condition: String?

    /// Component identifier
    ///
    /// The component identifier can be used to have an identifier if you need react on callback calls
    /// This is optional but recommended if you use a event handler function
    public let identifier: String?

    /// Event handler
    /// 
    /// The event handler is called when the component is interacted with.
    /// This can be a button press, a slider change, etc.
    public let eventHandler: String?

    /// Default value of component
    public let defaultValue: AnyCodable?

    /// Modifiers to components (not yet used)
    public var modifiers: [String: AnyCodable]?

    /// Parameters of component (not yet used)
    public let parameters: [String: AnyCodable]?

    /// URL
    public let url: String?

    /// Children (used in VStack, HStack, ZStack)
    public let children: [DynamicUIComponent]?

    // TODO: Find a way to move this to parameters
    /// Minimum value description
    ///
    /// - Note: This may be removed in the future in favor of ``parameters``.
    public let minimum: String?

    // TODO: Find a way to move this to parameters
    /// Minumum value
    ///
    /// - Note: This may be removed in the future in favor of ``parameters``.
    public let minimumValue: Double?

    // TODO: Find a way to move this to parameters
    /// Maximum value description
    ///
    /// - Note: This may be removed in the future in favor of ``parameters``.
    public let maximum: String?

    // TODO: Find a way to move this to parameters
    /// Maximum value
    ///
    /// - Note: This may be removed in the future in favor of ``parameters``.
    public let maximumValue: Double?

    /// Is the component disabled?
    public var disabled: Bool? = false

    /// The current state of an element
    ///
    /// The state can mean the state (on/off), but in case of a text field it can also mean the value of the text field.
    ///
    /// - Note: Do not init state in your UIComponent unless needed.
    public var state: AnyCodable?
}

extension DynamicUIComponent {
    /// Decode a component and discard metadata-only entries from its children.
    ///
    /// - Parameter decoder: Decoder containing a DynamicUI component object.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(String.self, forKey: .type)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        text = try container.decodeIfPresent(String.self, forKey: .text)
        condition = try container.decodeIfPresent(String.self, forKey: .condition)
        identifier = try container.decodeIfPresent(String.self, forKey: .identifier)
        eventHandler = try container.decodeIfPresent(String.self, forKey: .eventHandler)
        defaultValue = try container.decodeIfPresent(AnyCodable.self, forKey: .defaultValue)
        modifiers = try container.decodeIfPresent([String: AnyCodable].self, forKey: .modifiers)
        parameters = try container.decodeIfPresent([String: AnyCodable].self, forKey: .parameters)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        children = try container.decodeIfPresent(
            [DynamicUIComponentEntry].self,
            forKey: .children
        )?.compactMap(\.component)
        minimum = try container.decodeIfPresent(String.self, forKey: .minimum)
        minimumValue = try container.decodeIfPresent(Double.self, forKey: .minimumValue)
        maximum = try container.decodeIfPresent(String.self, forKey: .maximum)
        maximumValue = try container.decodeIfPresent(Double.self, forKey: .maximumValue)
        disabled = try container.decodeIfPresent(Bool.self, forKey: .disabled)
        state = try container.decodeIfPresent(AnyCodable.self, forKey: .state)
    }
}

/// Decodes a component only when an array entry declares a string `type` discriminator.
struct DynamicUIComponentEntry: Decodable {
    let component: DynamicUIComponent?

    private enum CodingKeys: String, CodingKey {
        case type
    }

    init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self),
              (try? container.decode(String.self, forKey: .type)) != nil else {
            component = nil
            return
        }

        component = try DynamicUIComponent(from: decoder)
    }
}

enum DynamicUILayoutDecoder {
    static func decode(from data: Data) throws -> [DynamicUIComponent] {
        try JSONDecoder()
            .decode([DynamicUIComponentEntry].self, from: data)
            .compactMap(\.component)
    }
}

extension DynamicUIComponent {
    /// Returns a component with conditional string expressions resolved.
    func resolvingStrings(values: [String: AnyCodable]) -> DynamicUIComponent {
        DynamicUIComponent(
            type: type,
            title: title.map { DynamicUIExpression.resolve($0, values: values) },
            text: text.map { DynamicUIExpression.resolve($0, values: values) },
            condition: condition,
            identifier: identifier,
            eventHandler: eventHandler,
            defaultValue: defaultValue,
            modifiers: modifiers?.mapValues { $0.resolvingStrings(values: values) },
            parameters: parameters?.mapValues { $0.resolvingStrings(values: values) },
            url: url.map { DynamicUIExpression.resolve($0, values: values) },
            children: children?.map { $0.resolvingStrings(values: values) },
            minimum: minimum.map { DynamicUIExpression.resolve($0, values: values) },
            minimumValue: minimumValue,
            maximum: maximum.map { DynamicUIExpression.resolve($0, values: values) },
            maximumValue: maximumValue,
            disabled: disabled,
            state: state
        )
    }

    /// Returns whether this component should be included in the rendered hierarchy.
    func shouldRender(values: [String: AnyCodable]) -> Bool {
        guard let condition else {
            return true
        }

        return DynamicUIExpression.evaluateCondition(condition, values: values)
    }
}

private extension AnyCodable {
    func resolvingStrings(values: [String: AnyCodable]) -> AnyCodable {
        switch self {
        case .string(let value):
            return .string(DynamicUIExpression.resolve(value, values: values))
        case .dictionary(let value):
            return .dictionary(value.mapValues { $0.resolvingStrings(values: values) })
        default:
            return self
        }
    }
}
