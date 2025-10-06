//
//  DynamicDisclosureGroup.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: DisclosureGroup
///
/// DynamicDisclosureGroup is a SwiftUI View that can be used to display an DisclosureGroup.
///
/// JSON Example:
/// ```json
/// {
///    "type": "DisclosureGroup",
///    "children": [ ]
/// }
/// ```
///
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicDisclosureGroup: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicDisclosureGroup
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
#if !os(tvOS) && !os(watchOS)
        DisclosureGroup("\(component.title ?? "")") {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
        .dynamicUIModifiers(component.modifiers)
#else
        DynamicVStack(component)
#endif
    }
}
