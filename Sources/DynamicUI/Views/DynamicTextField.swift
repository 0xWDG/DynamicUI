//
//  DynamicTextField.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: TextField
/// 
/// DynamicTextField is a SwiftUI View that can be used to display an TextField.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "TextField",
///    "title": "Title",
///    "defaultValue": "Default Value"
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead. this function is public to generate documentation.
public struct DynamicTextField: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    var dynamicUIEnvironment

    @State
    /// The state of the TextField
    private var state: String

    /// The component to display
    private let component: UIComponent

    /// Initialize the DynamicTextField
    init(_ component: UIComponent) {
        self.state = component.defaultValue?.toString() ?? ""
        self.component = component
    }

    /// Generated body for SwiftUI
    public var body: some View {
        TextField(
            "\(component.title ?? "")",
            text: $state
        )
    }
}
