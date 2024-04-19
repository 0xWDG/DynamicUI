//
//  DynamicProgressView.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: DynamicProgressView
/// DynamicProgressView is a SwiftUI View that can be used to display an progress view.
struct DynamicProgressView: View {
    private let component: UIComponent

    init(_ component: UIComponent) {
        self.component = component
    }

    public var body: some View {
        ProgressView(
            "\(component.title ?? "")",
            value: component.defaultValue?.toDouble() ?? 0,
            total: component.maximumValue ?? 100
        )
    }
}
