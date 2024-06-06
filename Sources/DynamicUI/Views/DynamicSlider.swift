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
///         Use ``DynamicUI`` instead. this function is public to generate documentation.
public struct DynamicSlider: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    @State
    /// The state of the Slider
    private var state: Double

    /// The component to display
    private let component: UIComponent

    /// Initialize the DynamicSlider
    init(_ component: UIComponent) {
        self.state = component.defaultValue?.toDouble() ?? 0
        self.component = component
    }

    /// Generated body for SwiftUI
    public var body: some View {
        Slider(value: $state) {
            Text("\(component.title ?? "")")
        } minimumValueLabel: {
            Text("\(component.minumum ?? "")")
        } maximumValueLabel: {
            Text("\(component.maximum ?? "")")
        }
    }
}
