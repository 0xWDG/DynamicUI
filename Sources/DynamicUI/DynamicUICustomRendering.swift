//
//  DynamicUICustomRendering.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI
import OSLog

extension DynamicUI {
    @ViewBuilder
    func customView(for component: DynamicUIComponent) -> some View {
        if let view = customViewRenderer?(component) {
            view.set(modifiers: component)
        } else {
            unsupportedView(for: component.type)
        }
    }

    private func unsupportedView(for type: String) -> EmptyView {
        Self.logger.error("Unsupported DynamicUI view type: \(type, privacy: .public)")
        return EmptyView()
    }
}
