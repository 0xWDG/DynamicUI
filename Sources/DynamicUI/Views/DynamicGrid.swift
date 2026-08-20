//
//  DynamicGrid.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Grid
struct DynamicGrid: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    @ViewBuilder
    var body: some View {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
                content
            }
            .set(modifiers: component)
        } else {
            VStack(spacing: verticalSpacing) {
                content
            }
            .set(modifiers: component)
        }
    }

    private var content: some View {
        dynamicUIEnvironment.buildView(for: component.children ?? [])
    }

    private var horizontalSpacing: CGFloat? {
        component.parameters?["horizontalSpacing"]?.toDouble().map { CGFloat($0) }
    }

    private var verticalSpacing: CGFloat? {
        component.parameters?["verticalSpacing"]?.toDouble().map { CGFloat($0) }
    }
}

#if DEBUG
#Preview("Grid") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "Grid",
            "children": [
                {
                    "type": "GridRow",
                    "children": [
                        { "type": "Text", "title": "Name" },
                        { "type": "Text", "title": "Value" }
                    ]
                },
                {
                    "type": "GridRow",
                    "children": [
                        { "type": "Text", "title": "Status" },
                        { "type": "Text", "title": "Ready" }
                    ]
                }
            ]
        }
        """)
}
#endif
