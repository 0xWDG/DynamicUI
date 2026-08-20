//
//  PreviewFixtures.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

#if DEBUG
import Foundation
import SwiftUI

/// Shared, self-contained fixtures for DynamicUI previews.
enum DynamicUIPreviewFixtures {
    static func view(_ componentJSON: String) -> some View {
        DynamicUI(
            json: "[\(componentJSON)]",
            component: .constant(nil)
        )
        .padding()
    }

    static func component(_ componentJSON: String) -> DynamicUIComponent? {
        try? JSONDecoder().decode(
            DynamicUIComponent.self,
            from: Data(componentJSON.utf8)
        )
    }
}
#endif
