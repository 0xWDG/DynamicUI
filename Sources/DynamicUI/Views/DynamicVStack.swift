//
//  DynamicVStack.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: VStack
/// 
/// DynamicVStack is a SwiftUI View that can be used to display an VStack.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "VStack",
///    "children": [ ]
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicVStack: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicVStack
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        VStack {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
        .set(modifiers: component)
    }
}
