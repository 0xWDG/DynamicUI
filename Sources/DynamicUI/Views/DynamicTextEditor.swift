//
//  DynamicTextEditor.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: TextEditor
/// 
/// DynamicTextEditor is a SwiftUI View that can be used to display an TextEditor.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "TextEditor",
///    "title": "Title",
///    "defaultValue": "Default Value"
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicTextEditor: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    var dynamicUIEnvironment

    @State
    /// The state of the TextEditor
    private var state: String

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicTextEditor
    init(_ component: DynamicUIComponent) {
        self.state = component.defaultValue?.toString() ?? ""
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
#if os(iOS) && os(macOS)
        TextEditor(text: $state.onChange({ _ in
            var newComponent = component
            newComponent.state = .string(state)

            dynamicUIEnvironment.callback(newComponent)
        }))
        .dynamicUIModifiers(component.modifiers)
#else
        DynamicTextField(component)
            .dynamicUIModifiers(component.modifiers)
#endif
    }
}
