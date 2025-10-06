//
//  DynamicTEMPLATE.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: TEMPLATE
/// 
/// DynamicTEMPLATE is a SwiftUI View that can be used to display an TEMPLATE.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "TEMPLATE",
///    "title": "Title"
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicTEMPLATE: View {
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
        EmptyView()
            .dynamicUIModifiers(component.modifiers)
    }
}
