//
//  DynamicShareLink.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: ShareLink
struct DynamicShareLink: View {
    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    @ViewBuilder
    var body: some View {
        if let value = component.url, let url = URL(string: value) {
#if os(tvOS)
            DynamicLink(component)
#else
            if #available(iOS 16.0, macOS 13.0, watchOS 9.0, *) {
                ShareLink(item: url) {
                    if let systemImage = component.parameters?["systemImage"]?.toString() {
                        Label(component.title ?? "Share", systemImage: systemImage)
                    } else {
                        Text(component.title ?? "Share")
                    }
                }
                .set(modifiers: component)
            } else {
                DynamicLink(component)
            }
#endif
        } else {
            Text(component.title ?? "Invalid share link")
                .accessibilityHint("The share URL is invalid")
                .set(modifiers: component)
        }
    }
}

#if DEBUG
#Preview("ShareLink") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "ShareLink",
            "title": "Share DynamicUI",
            "url": "https://github.com/0xWDG/DynamicUI",
            "parameters": { "systemImage": "square.and.arrow.up" }
        }
        """)
}
#endif
