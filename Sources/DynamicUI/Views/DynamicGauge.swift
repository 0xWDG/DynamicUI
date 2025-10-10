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
///         Use ``DynamicUI`` instead.
struct DynamicGauge: View {
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
    var body: some View {
#if !os(tvOS)
        if #available(macOS 13.0, iOS 16.0, *) {
            Gauge(value: state) {
                Text("\(component.title ?? "")")
            }
            .set(modifiers: component)

        } else {
            EmptyView()
        }
#else
        EmptyView()
#endif
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview("Gauge") {
    let json = """
        [
            {
                "type": "Form",
                "children": [
                    {
                        "type": "Section",
                        "title": "Gauge example",
                        "children": [
                            {
                                "type": "Gauge",
                                "title": "Gauge",
                                "defaultValue": 0.5
                            }
                        ]
                    }
                ]
            }
        ]
    """

    DynamicUI(json: json, component: .constant(nil))
}
#endif
