//
//  DynamicGauge.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: DynamicGauge
/// DynamicGauge is a SwiftUI View that can be used to display an Gauge.
struct DynamicGauge: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: UIComponent

    @State
    /// The state of the Gauge
    private var state: Double

    init(_ component: UIComponent) {
        self.state = component.defaultValue?.toDouble() ?? 0
        self.component = component
    }

    public var body: some View {
        if #available(macOS 13.0, *) {
            Gauge(value: state) {
                Text("\(component.title ?? "")")
            }
        } else {
            EmptyView()
        }
    }
}
