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

/// DynamicUI: Gauge
/// 
/// ⚠ DynamicGauge is a SwiftUI View that can be used to display an Gauge.
///
/// JSON Example:
/// ```json
/// {
///    "type": "Gauge",
///    "title": "Title",
///    "defaultValue": 0.5
/// }
/// ```
/// 
/// - Warning: This component is not finished yet.  
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead. this function is public to generate documentation.
public struct DynamicGauge: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    @State
    /// The state of the Gauge
    private var state: Double

    /// Initialize the DynamicGauge
    init(_ component: DynamicUIComponent) {
        self.state = component.defaultValue?.toDouble() ?? 0
        self.component = component
    }

    /// Generated body for SwiftUI
    public var body: some View {
        if #available(macOS 13.0, iOS 16.0, *) {
            Gauge(value: state) {
                Text("\(component.title ?? "")")
            }
        } else {
            EmptyView()
        }
    }
}
