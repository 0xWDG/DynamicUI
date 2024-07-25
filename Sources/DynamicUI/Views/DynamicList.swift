//
//  DynamicList.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: List
/// 
/// DynamicList is a SwiftUI View that can be used to display an List.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "List",
///    "children": [ ]
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead. this function is public to generate documentation.
public struct DynamicList: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicList
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    public var body: some View {
        List {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
        .dynamicUIModifiers(component.modifiers)
    }
}
