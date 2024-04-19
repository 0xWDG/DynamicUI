//
//  DynamicToggle.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 16/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: DynamicToggle
/// The DynamicToggle is a SwiftUI View that can be used to display a toggle.
struct DynamicToggle: View {
    @State private var state: Bool
    private let title: String

    init(_ component: UIComponent) {
        self.title = component.title ?? ""

        self.state = component.defaultValue?.toBool() ?? false
    }

    public var body: some View {
        Toggle(isOn: $state) {
            Text(title)
        }
    }
}
