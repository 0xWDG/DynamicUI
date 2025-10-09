//
//  DynamicSecureField.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: SecureField
/// 
/// DynamicSecureField is a SwiftUI View that can be used to display an SecureField.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "SecureField",
///    "title": "Title",
///    "defaultValue": "Default Value"
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicSecureField: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    var dynamicUIEnvironment

    @State
    /// The state of the SecureField
    private var state: String

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicSecureField
    init(_ component: DynamicUIComponent) {
        self.state = component.defaultValue?.toString() ?? ""
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        SecureField(
            "\(component.title ?? "")",
            text: $state
        )
        .disabled(component.disabled ?? false)
        .dynamicUIModifiers(component.modifiers)
    }
}
