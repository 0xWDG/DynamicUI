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

extension View {
    /// DynamicUIModifiers
    ///
    /// This function adds modifiers to a DynamicUIView
    ///
    /// - Parameter modifiers: The modifiers to apply
    /// 
    /// - Returns: The modified view
    public func dynamicUIModifiers(_ modifiers: [String: AnyCodable]?) -> some View {
        // swiftlint:disable:previous cyclomatic_complexity
        guard let modifiers = modifiers else {
            return AnyView(self)
        }

        let helper = DynamicUIHelper()
        var tempView = AnyView(self)

        modifiers.forEach { key, value in
            switch key {
            case "foregroundStyle":
                guard let string = value.toString(),
                      let color = helper.translateColor(string) else { return }
                tempView = AnyView(tempView.foregroundStyle(color))

            case "backgroundStyle":
                if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                    guard let string = value.toString(),
                          let color = helper.translateColor(string) else { return }
                    tempView = AnyView(tempView.backgroundStyle(color))
                }

            case "fontWeight":
                if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                    guard let string = value.toString(),
                          let weight = helper.translateFontWeight(string) else { return }
                    tempView = AnyView(tempView.fontWeight(weight))
                }

            case "font":
//                guard let color:
                    tempView = AnyView(tempView.font(.none))

            case "frame":
//                guard let color:
                // minWidth: <#0#>, idealWidth: <#100#>, maxWidth: <#.infinity#>, 
                // minHeight: <#0#>, idealHeight: <#100#>, maxHeight: <#.infinity#>, alignment: <#.center#>)
                // width: <#0#> height: <#0#>
                tempView = AnyView(tempView)

            case "padding":
                if let length = value.toInt() {
                    tempView = AnyView(tempView.padding(CGFloat(integerLiteral: length)))
                }

            case "opacity":
                guard let opacity = value.toDouble() else { break }
                tempView = AnyView(tempView.opacity(opacity))

            default:
                break
            }
        }

        return tempView
    }
}
