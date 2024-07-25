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

// swiftlint:disable cyclomatic_complexity function_body_length
/// DynamicUIHelper
///
/// DynamicUIHelper helps to translate Strings to native SwiftUI .context
public class DynamicUIHelper {

    /// Translate string colors to native ``Color``.
    ///
    /// - Parameter input: Color as string
    ///
    /// - Returns: SwiftUI ``Color``
    public func translateColor(_ input: String) -> Color? {
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

    /// Translate a string font weight to a native ``Font.Weight``
    ///
    /// - Parameter input: Font weight as string
    /// 
    /// - Returns: Translated ``Font.Weight``
    func translateFontWeight(_ input: String) -> Font.Weight? {
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
}

// swiftlint:enable cyclomatic_complexity function_body_length
