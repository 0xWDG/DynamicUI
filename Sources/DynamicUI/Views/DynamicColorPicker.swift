//
//  DynamicColorPicker.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: ColorPicker
struct DynamicColorPicker: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    @State private var state: Color

    private let component: DynamicUIComponent

    init(_ component: DynamicUIComponent) {
        self._state = State(
            initialValue: component.defaultValue?.toString()
                .flatMap(DynamicUIHelper.translateColor) ?? .accentColor
        )
        self.component = component
    }

    @ViewBuilder
    var body: some View {
#if os(tvOS) || os(watchOS)
        EmptyView()
#else
        ColorPicker(component.title ?? "Color", selection: $state, supportsOpacity: supportsOpacity)
            .dynamicUIOnChange(of: state, action: sendUpdate)
            .set(modifiers: component)
#endif
    }

    private var supportsOpacity: Bool {
        component.parameters?["supportsOpacity"]?.toBool() ?? true
    }

    private func sendUpdate(_ color: Color) {
        guard let hexadecimalColor = DynamicUIHelper.hexadecimalString(from: color) else {
            return
        }

        var updatedComponent = component
        updatedComponent.state = .string(hexadecimalColor)
        dynamicUIEnvironment.sendUpdate(updatedComponent)
    }
}

#if DEBUG
#Preview("ColorPicker") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "ColorPicker",
            "title": "Accent color",
            "defaultValue": "#3366FFFF"
        }
        """)
}
#endif
