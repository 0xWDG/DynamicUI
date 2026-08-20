//
//  DynamicStepper.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Stepper
struct DynamicStepper: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    @State private var state: Double

    private let component: DynamicUIComponent
    private let range: ClosedRange<Double>
    private let step: Double

    init(_ component: DynamicUIComponent) {
        let minimum = component.minimumValue ?? 0
        let maximum = max(component.maximumValue ?? 100, minimum)
        let initial = component.defaultValue?.toDouble() ?? minimum

        self._state = State(initialValue: min(max(initial, minimum), maximum))
        self.component = component
        self.range = minimum...maximum
        self.step = max(component.parameters?["step"]?.toDouble() ?? 1, .leastNonzeroMagnitude)
    }

    @ViewBuilder
    var body: some View {
#if os(tvOS)
        EmptyView()
#elseif os(watchOS)
        if #available(watchOS 9.0, *) {
            stepper
        } else {
            Text("\(component.title ?? "Value"): \(state.formatted())")
                .set(modifiers: component)
        }
#else
        stepper
#endif
    }

#if !os(tvOS)
    @available(watchOS 9.0, *)
    private var stepper: some View {
        Stepper(value: $state, in: range, step: step) {
            Text("\(component.title ?? "Value"): \(state.formatted())")
        }
        .dynamicUIOnChange(of: state, action: sendUpdate)
        .set(modifiers: component)
    }
#endif

    private func sendUpdate(_ value: Double) {
        var updatedComponent = component
        updatedComponent.state = .double(value)
        dynamicUIEnvironment.sendUpdate(updatedComponent)
    }
}

#if DEBUG
#Preview("Stepper") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "Stepper",
            "title": "Guests",
            "defaultValue": 2,
            "minimumValue": 1,
            "maximumValue": 10
        }
        """)
}
#endif
