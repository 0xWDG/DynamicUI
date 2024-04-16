//
//  Binding.onChange.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 16/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import Foundation

/// Any Codable supports different `Codable` types as `String`, `Int`, `Data`, `Double` and `Bool`.
/// This is made so you can use `AnyCodable?` in a codable struct so you can use dynamic types.
///
/// Example:
/// ```swift
/// struct WithAnyCodable: Codable, Hashable {
///   let someOptionalString: String?
///   let someOptionalCodable: AnyCodable?
/// }
/// ```
enum AnyCodable {
    case string(value: String)
    case int(value: Int)
    case data(value: Data)
    case double(value: Double)
    case bool(value: Bool)

    enum AnyCodableError: Error {
        case missingValue
    }
}

extension AnyCodable: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case string, int, data, double, bool
    }

    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(value: int)
            return
        }

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(value: string)
            return
        }

        if let data = try? decoder.singleValueContainer().decode(Data.self) {
            self = .data(value: data)
            return
        }

        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(value: double)
            return
        }

        if let bool = try? decoder.singleValueContainer().decode(Bool.self) {
            self = .bool(value: bool)
            return
        }

        self = .string(value: "")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .string(let value):
            try container.encode(value, forKey: .string)
        case .int(let value):
            try container.encode(value, forKey: .int)
        case .data(let value):
            try container.encode(value, forKey: .data)
        case .double(let value):
            try container.encode(value, forKey: .double)
        case .bool(let value):
            try container.encode(value, forKey: .bool)
        }
    }
}
