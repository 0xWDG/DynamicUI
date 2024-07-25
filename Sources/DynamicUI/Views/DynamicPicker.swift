//
//  DynamicPicker.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Picker
/// 
/// DynamicPicker is a SwiftUI View that can be used to display an Picker.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "Picker",
///    "title": "Title",
///    "values": ["...", "...", ]
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead. this function is public to generate documentation.
public struct DynamicPicker: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    @State
    /// The state of the picker
    private var state: Double

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicPicker
    init(_ component: DynamicUIComponent) {
        self.state = component.defaultValue?.toDouble() ?? 0
        self.component = component
    }

    /// Generated body for SwiftUI
    public var body: some View {
        Picker(component.title ?? "", selection: $state.onChange({ newState in
            var newComponent = component
            newComponent.state = .double(newState)

            dynamicUIEnvironment.callback(newComponent)
        })) {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
        .dynamicUIModifiers(component.modifiers)
    }
}
