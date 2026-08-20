//
//  DynamicLazyHGrid.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: LazyHGrid
struct DynamicLazyHGrid: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    var body: some View {
        LazyHGrid(
            rows: DynamicGridConfiguration.items(for: component, countKey: "rows"),
            spacing: DynamicGridConfiguration.spacing(for: component)
        ) {
            dynamicUIEnvironment.buildView(for: component.children ?? [])
        }
        .set(modifiers: component)
    }
}

enum DynamicGridConfiguration {
    static func items(for component: DynamicUIComponent, countKey: String) -> [GridItem] {
        let count = min(max(component.parameters?[countKey]?.toInt() ?? 1, 1), 50)
        let minimum = max(component.parameters?["minimum"]?.toDouble() ?? 10, 0)
        let maximum = max(component.parameters?["maximum"]?.toDouble() ?? .infinity, minimum)
        let spacing = spacing(for: component)
        let item = GridItem(
            .flexible(minimum: minimum, maximum: maximum),
            spacing: spacing
        )
        return Array(repeating: item, count: count)
    }

    static func spacing(for component: DynamicUIComponent) -> CGFloat? {
        component.parameters?["spacing"]?.toDouble().map { CGFloat($0) }
    }
}

#if DEBUG
#Preview("LazyHGrid") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "ScrollView",
            "children": [
                {
                    "type": "LazyHGrid",
                    "parameters": { "rows": 2, "spacing": 12 },
                    "children": [
                        { "type": "Text", "title": "One" },
                        { "type": "Text", "title": "Two" },
                        { "type": "Text", "title": "Three" },
                        { "type": "Text", "title": "Four" }
                    ],
                    "modifiers": { "frame": { "height": 100 } }
                }
            ]
        }
        """)
}
#endif
