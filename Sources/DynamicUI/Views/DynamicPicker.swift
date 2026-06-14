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
///         Use ``DynamicUI`` instead.
struct DynamicPicker: View {
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
        let lastIndex = Double(max((component.children?.count ?? 1) - 1, 0))
        let initialValue = component.defaultValue?.toDouble() ?? 0

        self._state = State(initialValue: min(max(initialValue, 0), lastIndex))
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        Picker(component.title ?? "", selection: $state) {
            if let children = component.children {
                ForEach(children.indices, id: \.self) { index in
                    dynamicUIEnvironment.buildView(for: [children[index]])
                        .tag(Double(index))
                }
            }
        }
        .onChange(of: state, perform: sendUpdate)
        .set(modifiers: component)
    }

    private func sendUpdate(_ state: Double) {
        var updatedComponent = component
        updatedComponent.state = .double(state)
        dynamicUIEnvironment.sendUpdate(updatedComponent)
    }
}
