//
//  DynamicLink.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Link
struct DynamicLink: View {
    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    @ViewBuilder
    var body: some View {
        if let value = component.url, let url = URL(string: value) {
            Link(destination: url) {
                if let systemImage = component.parameters?["systemImage"]?.toString() {
                    Label(component.title ?? value, systemImage: systemImage)
                } else {
                    Text(component.title ?? value)
                }
            }
            .set(modifiers: component)
        } else {
            Text(component.title ?? "Invalid link")
                .accessibilityHint("The link URL is invalid")
                .set(modifiers: component)
        }
    }
}

#if DEBUG
#Preview("Link") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "Link",
            "title": "Open DynamicUI",
            "url": "https://github.com/0xWDG/DynamicUI",
            "parameters": { "systemImage": "link" }
        }
        """)
}
#endif
