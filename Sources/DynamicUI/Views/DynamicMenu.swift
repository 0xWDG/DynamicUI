//
//  DynamicMenu.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Menu
struct DynamicMenu: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    @ViewBuilder
    var body: some View {
#if os(watchOS)
        fallback
#elseif os(tvOS)
        if #available(tvOS 17.0, *) {
            menu
        } else {
            fallback
        }
#else
        menu
#endif
    }

#if !os(watchOS)
    @available(tvOS 17.0, *)
    private var menu: some View {
        Menu {
            dynamicUIEnvironment.buildView(for: component.children ?? [])
        } label: {
            if let systemImage = component.url {
                Label(component.title ?? "Menu", systemImage: systemImage)
            } else {
                Text(component.title ?? "Menu")
            }
        }
        .set(modifiers: component)
    }
#endif

    private var fallback: some View {
        VStack(alignment: .leading) {
            Text(component.title ?? "Menu")
                .font(.headline)
            dynamicUIEnvironment.buildView(for: component.children ?? [])
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(component.title ?? "Menu")
        .set(modifiers: component)
    }
}

#if DEBUG
#Preview("Menu") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "Menu",
            "title": "Actions",
            "url": "ellipsis.circle",
            "children": [
                { "type": "Button", "title": "Duplicate" },
                { "type": "Button", "title": "Delete" }
            ]
        }
        """)
}
#endif
