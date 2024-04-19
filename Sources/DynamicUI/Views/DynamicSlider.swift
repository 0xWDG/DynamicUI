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

/// DynamicUI: DynamicSlider
/// The DynamicSlider is a SwiftUI View that can be used to display a slider.
struct DynamicSlider: View {
    @State private var state: Double
    private let component: UIComponent

    init(_ component: UIComponent) {
        self.state = component.defaultValue?.toDouble() ?? 0
        self.component = component
    }

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
