//
//  DynamicAsyncImage.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: AsyncImage
struct DynamicAsyncImage: View {
    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    @ViewBuilder
    var body: some View {
        if let url = remoteURL {
            AsyncImage(url: url) { phase in
                image(for: phase)
            }
            .set(modifiers: component)
        } else {
            Label(component.title ?? "Invalid image URL", systemImage: "photo")
                .accessibilityHint("The remote image URL is invalid")
                .set(modifiers: component)
        }
    }

    @ViewBuilder
    private func image(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView(component.title ?? "Loading image")

        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .accessibilityLabel(component.title ?? "Image")

        case .failure:
            Label(component.title ?? "Image unavailable", systemImage: "photo")
                .accessibilityHint("The remote image could not be loaded")

        @unknown default:
            EmptyView()
        }
    }

    private var remoteURL: URL? {
        guard let value = component.url,
              let url = URL(string: value),
              url.scheme == "http" || url.scheme == "https" else {
            return nil
        }
        return url
    }

    private var contentMode: ContentMode {
        component.parameters?["contentMode"]?.toString() == "fill" ? .fill : .fit
    }
}

#if DEBUG
#Preview("AsyncImage") {
    DynamicUIPreviewFixtures.view("""
        {
        "type": "VStack",
        "children": [
            {
                "type": "AsyncImage",
                "title": "Wesley's avatar",
                "url": "https://wesleydegroot.nl/assets/avatar/avatar.webp"
            },
            { "type": "Divider" },
            {
                "type": "AsyncImage",
                "title": "Remote image preview",
                "url": "invalid-preview-url"
            }
        ]
        }
        """)
}
#endif
