//
//  DynamicGroupBox.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: DynamicGroupBox
/// DynamicGroupBox is a SwiftUI View that can be used to display an GroupBox.
struct DynamicGroupBox: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: UIComponent

    init(_ component: UIComponent) {
        self.component = component
    }

    public var body: some View {
         GroupBox {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
    }
}
