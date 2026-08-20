//
//  DynamicLazyVGrid.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: LazyVGrid
struct DynamicLazyVGrid: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    var body: some View {
        LazyVGrid(
            columns: DynamicGridConfiguration.items(for: component, countKey: "columns"),
            spacing: DynamicGridConfiguration.spacing(for: component)
        ) {
            dynamicUIEnvironment.buildView(for: component.children ?? [])
        }
        .set(modifiers: component)
    }
}

#if DEBUG
#Preview("LazyVGrid") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "LazyVGrid",
            "parameters": { "columns": 2, "spacing": 12 },
            "children": [
                { "type": "Text", "title": "One" },
                { "type": "Text", "title": "Two" },
                { "type": "Text", "title": "Three" },
                { "type": "Text", "title": "Four" }
            ]
        }
        """)
}
#endif
