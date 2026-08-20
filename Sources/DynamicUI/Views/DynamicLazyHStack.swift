//
//  DynamicLazyHStack.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: LazyHStack
struct DynamicLazyHStack: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    var body: some View {
        LazyHStack(alignment: alignment, spacing: spacing) {
            dynamicUIEnvironment.buildView(for: component.children ?? [])
        }
        .set(modifiers: component)
    }

    private var alignment: VerticalAlignment {
        switch component.parameters?["alignment"]?.toString() {
        case "top": .top
        case "bottom": .bottom
        default: .center
        }
    }

    private var spacing: CGFloat? {
        component.parameters?["spacing"]?.toDouble().map { CGFloat($0) }
    }
}

#if DEBUG
#Preview("LazyHStack") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "ScrollView",
            "children": [
                {
                    "type": "LazyHStack",
                    "parameters": { "spacing": 16 },
                    "children": [
                        { "type": "Text", "title": "First" },
                        { "type": "Text", "title": "Second" },
                        { "type": "Text", "title": "Third" }
                    ]
                }
            ]
        }
        """)
}
#endif
