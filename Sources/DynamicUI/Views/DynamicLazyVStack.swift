//
//  DynamicLazyVStack.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: LazyVStack
struct DynamicLazyVStack: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    var body: some View {
        LazyVStack(alignment: alignment, spacing: spacing) {
            dynamicUIEnvironment.buildView(for: component.children ?? [])
        }
        .set(modifiers: component)
    }

    private var alignment: HorizontalAlignment {
        switch component.parameters?["alignment"]?.toString() {
        case "leading": .leading
        case "trailing": .trailing
        default: .center
        }
    }

    private var spacing: CGFloat? {
        component.parameters?["spacing"]?.toDouble().map { CGFloat($0) }
    }
}

#if DEBUG
#Preview("LazyVStack") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "LazyVStack",
            "parameters": { "alignment": "leading", "spacing": 12 },
            "children": [
                { "type": "Text", "title": "First" },
                { "type": "Text", "title": "Second" },
                { "type": "Text", "title": "Third" }
            ]
        }
        """)
}
#endif
