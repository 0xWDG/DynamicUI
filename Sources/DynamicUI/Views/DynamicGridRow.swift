//
//  DynamicGridRow.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: GridRow
struct DynamicGridRow: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    @ViewBuilder
    var body: some View {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            GridRow {
                content
            }
            .set(modifiers: component)
        } else {
            HStack {
                content
            }
            .set(modifiers: component)
        }
    }

    private var content: some View {
        dynamicUIEnvironment.buildView(for: component.children ?? [])
    }
}

#if DEBUG
#Preview("GridRow") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "Grid",
            "children": [
                {
                    "type": "GridRow",
                    "children": [
                        { "type": "Text", "title": "First cell" },
                        { "type": "Text", "title": "Second cell" }
                    ]
                }
            ]
        }
        """)
}
#endif
