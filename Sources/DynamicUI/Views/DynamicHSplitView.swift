//
//  DynamicHSplitView.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: HSplitView
/// 
/// DynamicHSplitView is a SwiftUI View that can be used to display an HSplitView.
/// JSON Example:
/// ```json
/// {
///    "type": "HSplitView",
///    "children": [ ]
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicHSplitView: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicHSplitView
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
#if os(macOS)
        HSplitView {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
        .disabled(component.disabled ?? false)
        .dynamicUIModifiers(component.modifiers)
#else
        EmptyView()
            .dynamicUIModifiers(component.modifiers)
#endif
    }
}
