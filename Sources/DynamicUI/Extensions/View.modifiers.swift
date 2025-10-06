//
//  Modifiers.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 25/07/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

public struct DynamicUIModifier: ViewModifier {
    /// The modifiers to apply
    let modifiers: [String: AnyCodable]?
    let helper = DynamicUIHelper()

    // TODO: Ideally make this a @ViewBuilder and remove the need of AnyView
    public func body(content: Content) -> some View {
        // swiftlint:disable:next cyclomatic_complexity
        var tempView = AnyView(content)

        modifiers?.forEach { key, value in
            switch key {
            case "foregroundStyle", "foregroundColor":
                guard #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *),
                      let string = value.toString(),
                      let color = helper.translateColor(string) else { break }
                tempView = AnyView(tempView.foregroundStyle(color))

            case "backgroundStyle", "backgroundColor":
                guard #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *),
                      let string = value.toString(),
                      let color = helper.translateColor(string) else { break }
                tempView = AnyView(tempView.backgroundStyle(color))

            case "fontWeight":
                guard #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *),
                      let string = value.toString(),
                      let weight = helper.translateFontWeight(string) else { break }
                tempView = AnyView(tempView.fontWeight(weight))

            case "font":
                guard #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *) else { break }
                tempView = AnyView(tempView.font(.none))

            case "frame":
                guard #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *) else { break }
                tempView = AnyView(
                    tempView.frame(
                        minWidth: nil,
                        idealWidth: nil,
                        maxWidth: nil,
                        minHeight: nil,
                        idealHeight: nil,
                        maxHeight: nil,
                        alignment: .center
                    )
                )

            case "padding":
                guard #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *),
                      let length = value.toInt() else { break }
                tempView = AnyView(tempView.padding(CGFloat(integerLiteral: length)))

            case "opacity":
                guard #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *),
                      let opacity = value.toDouble() else { break }
                tempView = AnyView(tempView.opacity(opacity))

            default:
                break
            }
        }

        return tempView
    }
}

extension View {
    /// DynamicUIModifiers
    ///
    /// This function adds modifiers to a DynamicUIView
    ///
    /// - Parameter modifiers: The modifiers to apply
    ///
    /// - Returns: The modified view
    public func dynamicUIModifiers(_ modifiers: [String: AnyCodable]?) -> some View {
        self.modifier(DynamicUIModifier(modifiers: modifiers))
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview {
    Text("Test")
        .dynamicUIModifiers(["foregroundStyle": .string("red")])
}
#endif
