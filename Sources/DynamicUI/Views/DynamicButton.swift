//
//  DynamicButton.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Button
///
/// DynamicButton is a SwiftUI View that can be used to display an Button.
///
/// JSON Example:
/// ```json
/// {
///    "type": "Button",
///    "title": "Title",
///    "modifiers": {
///        "foregroundColor": "purple"
///    }
/// }
/// ```
///
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicButton: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The state of the Button
    @State
    private var state: Double

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicButton
    init(_ component: DynamicUIComponent) {
        self.state = component.defaultValue?.toDouble() ?? 0
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        Button(action: {
            dynamicUIEnvironment.component = component
        }, label: {
            Text(component.title ?? "Button")
        })
        .disabled(component.disabled ?? false)
        .dynamicUIModifiers(component.modifiers)
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview("Button") {
    let json = """
        [
            {
               "type": "Button",
               "title": "Title",
               "modifiers": {
                   "foregroundColor": "purple"
               }
            }
        ]
    """

    DynamicUI(json: json, component: .constant(nil))
}
#endif
