//
//  DynamicPicker.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: DynamicPicker
/// DynamicPicker is a SwiftUI View that can be used to display an Picker.
public struct DynamicPicker: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    @State
    private var state: Double

    private let component: UIComponent

    init(_ component: UIComponent) {
        self.state = component.defaultValue?.toDouble() ?? 0
        self.component = component
    }

    public var body: some View {
        Picker(component.title ?? "", selection: $state) {
            if let children = component.children {
               AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
    }
}
