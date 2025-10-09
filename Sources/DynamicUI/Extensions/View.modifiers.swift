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

struct DynamicUIModifier: ViewModifier {
    /// The modifiers to apply
    let modifiers: [String: AnyCodable]?

    // TODO: Ideally, this function would use @ViewBuilder to avoid type erasure with AnyView,
    //       which would improve type safety and allow for more natural SwiftUI composition.
    //       However, applying modifiers dynamically based on a dictionary of keys and values
    //       currently requires type erasure, since @ViewBuilder expects a static view hierarchy.
    //       Investigate approaches to apply modifiers in a type-safe way without AnyView,
    //       possibly by refactoring how modifiers are represented or applied.
    func body(content: Content) -> some View {
        // swiftlint:disable:previous cyclomatic_complexity function_body_length
        var tempView = AnyView(content)

        modifiers?.forEach { key, value in
            switch key {
            case "foregroundStyle", "foregroundColor":
                guard #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *),
                      let string = value.toString(),
                      let color = DynamicUIHelper.translateColor(string) else { break }
                tempView = AnyView(tempView.foregroundStyle(color))

            case "background", "backgroundColor":
                guard #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *),
                      let string = value.toString(),
                      let color = DynamicUIHelper.translateColor(string) else { break }
                tempView = AnyView(tempView.background(color))

            case "fontWeight":
                guard #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *),
                      let string = value.toString(),
                      let weight = DynamicUIHelper.translateFontWeight(string) else { break }
                tempView = AnyView(tempView.fontWeight(weight))

            case "font":
                guard #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *) else { break }
                tempView = AnyView(tempView.font(.none))

            case "frame":
                guard #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *) else { break }
                if let frameDict = value.toDictionary() {
                    let width = frameDict["width"]?.toDouble().map { CGFloat($0) }
                    let height = frameDict["height"]?.toDouble().map { CGFloat($0) }
                    let minWidth = frameDict["minWidth"]?.toDouble().map { CGFloat($0) }
                    let idealWidth = frameDict["idealWidth"]?.toDouble().map { CGFloat($0) }
                    let maxWidth = frameDict["maxWidth"]?.toDouble().map { CGFloat($0) }
                    let minHeight = frameDict["minHeight"]?.toDouble().map { CGFloat($0) }
                    let idealHeight = frameDict["idealHeight"]?.toDouble().map { CGFloat($0) }
                    let maxHeight = frameDict["maxHeight"]?.toDouble().map { CGFloat($0) }
                    let alignment = DynamicUIHelper.translateAlignment(frameDict["alignment"]?.toString())

                    if width != nil || height != nil {
                        tempView = AnyView(
                            tempView.frame(
                                width: width,
                                height: height,
                                alignment: alignment
                            )
                        )
                    } else {
                        tempView = AnyView(
                            tempView.frame(
                                minWidth: minWidth,
                                idealWidth: idealWidth,
                                maxWidth: maxWidth,
                                minHeight: minHeight,
                                idealHeight: idealHeight,
                                maxHeight: maxHeight,
                                alignment: alignment
                            )
                        )
                    }
                }

            case "opacity":
                guard #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *),
                      let opacity = value.toDouble() else { break }
                tempView = AnyView(tempView.opacity(opacity))

            case "disabled":
                guard #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *),
                      let disabled = value.toBool() else { break }
                tempView = AnyView(tempView.disabled(disabled))

            case "padding":
                if value.toBool() != nil {
                    tempView = AnyView(tempView.padding())
                } else if let padding = value.toDouble() {
                    tempView = AnyView(tempView.padding(padding))
                } else {
                    break
                }

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
    func dynamicUIModifiers(_ modifiers: [String: AnyCodable]?) -> some View {
        self.modifier(DynamicUIModifier(modifiers: modifiers))
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview {
    Text("Test")
        .dynamicUIModifiers([
            "frame": .dictionary([
                "width": .double(150),
                "height": .double(100)
            ]),
            "foregroundStyle": .string("red"),
            "disabled": .bool(true)
        ])
}
#endif
