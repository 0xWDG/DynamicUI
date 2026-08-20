//
//  DynamicUIHelper.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 25/07/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// swiftlint:disable cyclomatic_complexity function_body_length
/// DynamicUIHelper
///
/// DynamicUIHelper helps to translate Strings to native SwiftUI .context
class DynamicUIHelper {

    /// Translate string colors to native ``Color``.
    ///
    /// - Parameter input: Color as string
    ///
    /// - Returns: SwiftUI ``Color``
    static func translateColor(_ input: String) -> Color? {
        if let color = translateHexColor(input) {
            return color
        }

        switch input.lowercased() {
        case "red":
            return .red

        case "orange":
            return .orange

        case "yellow":
            return .yellow

        case "green":
            return .green

        case "mint":
            if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                return .mint
            }
            return .primary

        case "teal":
            if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                return .teal
            }
            return .primary

        case "cyan":
            if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                return .cyan
            }
            return .primary

        case "blue":
            return .blue

        case "indigo":
            if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                return .indigo
            }
            return .primary

        case "purple":
            return .purple

        case "pink":
            return .pink

        case "brown":
            if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                return .brown
            }
            return .primary

        case "white":
            return .white

        case "gray":
            return .gray

        case "black":
            return .black

        case "clear":
            return .clear

        case "primary":
            return .primary

        case "secondary":
            return .secondary

        default:
            return .primary
        }
    }

    /// Translate a SwiftUI color to an eight-digit hexadecimal RGBA string.
    static func hexadecimalString(from color: Color) -> String? {
#if canImport(UIKit)
        let platformColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard platformColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
#elseif canImport(AppKit)
        guard let platformColor = NSColor(color).usingColorSpace(.sRGB) else {
            return nil
        }
        let red = platformColor.redComponent
        let green = platformColor.greenComponent
        let blue = platformColor.blueComponent
        let alpha = platformColor.alphaComponent
#else
        return nil
#endif

        return String(
            format: "#%02X%02X%02X%02X",
            Int(round(red * 255)),
            Int(round(green * 255)),
            Int(round(blue * 255)),
            Int(round(alpha * 255))
        )
    }

    private static func translateHexColor(_ input: String) -> Color? {
        let hex = input.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        guard hex.count == 6 || hex.count == 8,
              let value = UInt64(hex, radix: 16) else {
            return nil
        }

        let hasAlpha = hex.count == 8
        let red = Double((value >> (hasAlpha ? 24 : 16)) & 0xFF) / 255
        let green = Double((value >> (hasAlpha ? 16 : 8)) & 0xFF) / 255
        let blue = Double((value >> (hasAlpha ? 8 : 0)) & 0xFF) / 255
        let alpha = hasAlpha ? Double(value & 0xFF) / 255 : 1
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }

    /// Translate a string font weight to a native ``Font.Weight``
    ///
    /// - Parameter input: Font weight as string
    /// 
    /// - Returns: Translated ``Font.Weight``
    static func translateFontWeight(_ input: String) -> Font.Weight? {
        switch input {
        case "ultraLight":
            return .ultraLight

        case "thin":
            return .thin

        case "light":
            return .light

        case "regular":
            return .regular

        case "medium":
            return .medium

        case "semibold":
            return .semibold

        case "bold":
            return .bold

        case "heavy":
            return .heavy

        case "black":
            return .black

        default:
            return .regular
        }
    }

    static func translateAlignment(_ input: String?) -> Alignment {
        switch input {
        case "leading":
            return .leading
        case "center":
            return .center
        case "trailing":
            return .trailing
        default:
            return .center
        }
    }

    /// Translate a dynamic font value to a native ``Font``.
    ///
    /// - Parameter input: A text style string or dictionary containing `size` and optional `weight`.
    /// - Returns: Translated ``Font``, or `nil` for an unsupported value.
    static func translateFont(_ input: AnyCodable) -> Font? {
        if let style = input.toString() {
            switch style {
            case "largeTitle":
                return .largeTitle
            case "title":
                return .title
            case "title2":
                return .title2
            case "title3":
                return .title3
            case "headline":
                return .headline
            case "subheadline":
                return .subheadline
            case "body":
                return .body
            case "callout":
                return .callout
            case "footnote":
                return .footnote
            case "caption":
                return .caption
            case "caption2":
                return .caption2
            default:
                return nil
            }
        }

        guard let font = input.toDictionary(),
              let size = font["size"]?.toDouble() else {
            return nil
        }

        let weight = font["weight"]?.toString()
            .flatMap(translateFontWeight) ?? .regular
        return .system(size: size, weight: weight)
    }

    /// Translate a dictionary of edge values to native ``EdgeInsets``.
    ///
    /// - Parameter input: Edge values keyed by `top`, `leading`, `bottom`, and `trailing`.
    /// - Returns: Translated ``EdgeInsets``.
    static func translateEdgeInsets(_ input: [String: AnyCodable]) -> EdgeInsets {
        EdgeInsets(
            top: input["top"]?.toDouble() ?? 0,
            leading: input["leading"]?.toDouble() ?? 0,
            bottom: input["bottom"]?.toDouble() ?? 0,
            trailing: input["trailing"]?.toDouble() ?? 0
        )
    }
}

/// Resolves conditional expressions used in string values from the JSON layout.
enum DynamicUIExpression {
    /// Evaluate a component condition such as `$toggle`.
    ///
    /// - Parameters:
    ///   - input: An identifier prefixed with `$`.
    ///   - values: Current component values keyed by identifier.
    /// - Returns: Whether the referenced value is truthy.
    static func evaluateCondition(_ input: String, values: [String: AnyCodable]) -> Bool {
        let expression = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard expression.hasPrefix("$") else {
            return false
        }

        let identifier = expression.dropFirst().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !identifier.isEmpty else {
            return false
        }

        return values[identifier]?.isTruthy == true
    }

    /// Resolve an expression such as `{$toggle ? star.fill : star}`.
    ///
    /// - Parameters:
    ///   - input: The string that may contain a conditional expression.
    ///   - values: Current component values keyed by identifier.
    /// - Returns: The selected conditional value, or the original input when it is not an expression.
    static func resolve(_ input: String, values: [String: AnyCodable]) -> String {
        guard input.hasPrefix("{$"),
              input.hasSuffix("}"),
              let questionMark = input.firstIndex(of: "?"),
              let colon = input[questionMark...].firstIndex(of: ":") else {
            return input
        }

        let identifierStart = input.index(input.startIndex, offsetBy: 2)
        let identifier = input[identifierStart..<questionMark].trimmingCharacters(in: .whitespacesAndNewlines)
        let trueValueStart = input.index(after: questionMark)
        let trueValue = input[trueValueStart..<colon].trimmingCharacters(in: .whitespacesAndNewlines)
        let falseValueStart = input.index(after: colon)
        let falseValueEnd = input.index(before: input.endIndex)
        let falseValue = input[falseValueStart..<falseValueEnd].trimmingCharacters(in: .whitespacesAndNewlines)

        guard !identifier.isEmpty, !trueValue.isEmpty, !falseValue.isEmpty else {
            return input
        }

        return values[identifier]?.isTruthy == true ? trueValue : falseValue
    }
}

private extension AnyCodable {
    var isTruthy: Bool {
        switch self {
        case .bool(let value):
            return value
        case .int(let value):
            return value != 0
        case .double(let value):
            return value != 0
        case .string(let value):
            return !value.isEmpty
        case .data(let value):
            return !value.isEmpty
        case .dictionary(let value):
            return !value.isEmpty
        case .none:
            return false
        }
    }
}

// swiftlint:enable cyclomatic_complexity function_body_length
