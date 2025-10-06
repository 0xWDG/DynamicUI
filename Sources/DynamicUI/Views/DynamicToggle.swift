//
//  DynamicToggle.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 16/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Toggle
/// 
/// The DynamicToggle is a SwiftUI View that can be used to display a toggle.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "Toggle",
///    "title": "Title",
///    "defaultValue": true
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicToggle: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    var dynamicUIEnvironment

    @State
    /// The state of the Toggle
    private var state: Bool

    /// The title of the Toggle
    private let title: String

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicToggle
    init(_ component: DynamicUIComponent) {
        self.title = component.title ?? ""
        self.state = component.defaultValue?.toBool() ?? false
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        Toggle(isOn: $state.onChange({ newState in
            var newComponent = component
            newComponent.state = .bool(newState)

            dynamicUIEnvironment.component = newComponent
        })) {
            Text(title)
        }
        .dynamicUIModifiers(component.modifiers)
    }
}
