//
//  DynamicTabView.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 14/06/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: TabView
///
/// DynamicTabView is a SwiftUI View that displays its children as tabs.
///
/// JSON Example:
/// ```json
/// {
///    "type": "TabView",
///    "children": [ ]
/// }
/// ```
///
/// - Note: This is an internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicTabView: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicTabView
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        TabView {
            if let children = component.children {
                ForEach(children.indices, id: \.self) { index in
                    let child = children[index]

                    dynamicUIEnvironment.buildView(for: [child])
                        .tabItem {
                            if let systemImage = child.url {
                                Label(child.title ?? "", systemImage: systemImage)
                            } else {
                                Text(child.title ?? "")
                            }
                        }
                }
            }
        }
        .set(modifiers: component)
    }
}
