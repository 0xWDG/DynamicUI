//
//  DynamicNavigationLink.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: NavigationLink
struct DynamicNavigationLink: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    var body: some View {
        NavigationLink {
            dynamicUIEnvironment.buildView(for: component.children ?? [])
        } label: {
            if let systemImage = component.url {
                Label(component.title ?? "Open", systemImage: systemImage)
            } else {
                Text(component.title ?? "Open")
            }
        }
        .set(modifiers: component)
    }
}

#if DEBUG
#Preview("NavigationLink") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "NavigationStack",
            "children": [
                {
                    "type": "NavigationLink",
                    "title": "Open details",
                    "url": "chevron.right",
                    "children": [
                        { "type": "Text", "title": "Detail content" }
                    ]
                }
            ]
        }
        """)
}
#endif
