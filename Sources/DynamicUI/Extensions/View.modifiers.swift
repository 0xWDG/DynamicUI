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

    // TODO: Ideally, this function would use @ViewBuilder to avoid type erasure with AnyView,
    //       which would improve type safety and allow for more natural SwiftUI composition.
    //       However, applying modifiers dynamically based on a dictionary of keys and values
    //       currently requires type erasure, since @ViewBuilder expects a static view hierarchy.
    //       Investigate approaches to apply modifiers in a type-safe way without AnyView,
    //       possibly by refactoring how modifiers are represented or applied.
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
                if let frameDict = value.value as? [String: AnyCodable] {
                    let minWidth = frameDict["minWidth"]?.toDouble().map { CGFloat($0) }
                    let idealWidth = frameDict["idealWidth"]?.toDouble().map { CGFloat($0) }
                    let maxWidth = frameDict["maxWidth"]?.toDouble().map { CGFloat($0) }
                    let minHeight = frameDict["minHeight"]?.toDouble().map { CGFloat($0) }
                    let idealHeight = frameDict["idealHeight"]?.toDouble().map { CGFloat($0) }
                    let maxHeight = frameDict["maxHeight"]?.toDouble().map { CGFloat($0) }
                    let alignmentString = frameDict["alignment"]?.toString()
                    let alignment = alignmentString.flatMap { helper.translateAlignment($0) } ?? .center
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
