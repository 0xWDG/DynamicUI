//
//  DynamicNavigationSplitView.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 14/06/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: NavigationSplitView
///
/// DynamicNavigationSplitView uses the first child as its sidebar and the remaining children as detail content.
///
/// JSON Example:
/// ```json
/// {
///    "type": "NavigationSplitView",
///    "children": [ ]
/// }
/// ```
///
/// - Note: This is an internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicNavigationSplitView: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicNavigationSplitView
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    @ViewBuilder
    var body: some View {
#if os(watchOS)
        fallbackView
#else
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, *) {
            NavigationSplitView {
                sidebar
            } detail: {
                detail
            }
            .set(modifiers: component)
        } else {
            fallbackView
        }
#endif
    }

    private var sidebar: some View {
        dynamicUIEnvironment.buildView(for: Array((component.children ?? []).prefix(1)))
    }

    private var detail: some View {
        dynamicUIEnvironment.buildView(for: Array((component.children ?? []).dropFirst()))
    }

    private var fallbackView: some View {
        NavigationView {
            sidebar
            detail
        }
        .set(modifiers: component)
    }
}
