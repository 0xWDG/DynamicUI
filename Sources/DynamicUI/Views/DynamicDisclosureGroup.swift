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
///         Use ``DynamicUI`` instead. this function is public to generate documentation.
public struct DynamicDisclosureGroup: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: UIComponent

    /// Initialize the DynamicDisclosureGroup
    public init(_ component: UIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    public var body: some View {
        DisclosureGroup("\(component.title ?? "")") {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
    }
}
