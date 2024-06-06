//
//  DynamicLabel.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: DynamicLabel
/// DynamicLabel is a SwiftUI View that can be used to display an Label.
struct DynamicLabel: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: UIComponent

    init(_ component: UIComponent) {
        self.component = component
    }

    public var body: some View {
        Label(Text("\(component.title)"), systemImage: component.imageURL ?? "")
    }
}
