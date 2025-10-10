//
//  DynamicSlider.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Slider
/// 
/// The DynamicSlider is a SwiftUI View that can be used to display a slider.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "Slider",
///    "title": "Title",
///    "minLabel": "0",
///    "maxLabel": "100"
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicSlider: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    @State
    /// The state of the Slider
    private var state: Double

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicSlider
    init(_ component: DynamicUIComponent) {
        self.state = component.defaultValue?.toDouble() ?? 0
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
#if !os(tvOS)
        Slider(value: $state.onChange({ newState in
            var newComponent = component
            newComponent.state = .double(newState)

            dynamicUIEnvironment.component = newComponent
        })) {
            Text("\(component.title ?? "")")
        } minimumValueLabel: {
            Text("\(component.minimum ?? "")")
        } maximumValueLabel: {
            Text("\(component.maximum ?? "")")
        }
        .set(modifiers: component)

#else
        EmptyView()
#endif
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview("Slider") {
    let json = """
        [
            {
                "type": "Form",
                "children": [
                    {
                        "type": "Slider",
                        "title": "Form example",
                        "defaultValue": 0.5,
                        "minimum": "Minimum",
                        "maximum": "Maximum"
                    }
                ]
            }
        ]
    """

    DynamicUI(json: json, component: .constant(nil))
}
#endif
