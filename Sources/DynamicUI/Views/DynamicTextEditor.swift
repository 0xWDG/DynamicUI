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
#if os(iOS) || os(macOS)
        TextEditor(text: $state)
        .dynamicUIOnChange(of: state, action: sendUpdate)
        .set(modifiers: component)
#else
        DynamicTextField(component)
#endif
    }

    private func sendUpdate(_ state: String) {
        var updatedComponent = component
        updatedComponent.state = .string(state)
        dynamicUIEnvironment.sendUpdate(updatedComponent)
    }
}

#if DEBUG
#Preview("TextEditor") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "TextEditor",
            "defaultValue": "Editable multiline text",
            "modifiers": { "frame": { "height": 100 } }
        }
        """)
}
#endif
