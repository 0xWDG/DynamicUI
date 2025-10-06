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
///        "foregroundColor": "blue"
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

    @State
    /// The state of the TEMPLATE
    private var state: Double

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicTEMPLATE
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
        .dynamicUIModifiers(component.modifiers)
    }
}
