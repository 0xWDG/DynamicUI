//
//  DynamicVSplitView.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: DynamicVSplitView
/// DynamicVSplitView is a SwiftUI View that can be used to display an VSplitView.
struct DynamicVSplitView: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: UIComponent

    init(_ component: UIComponent) {
        self.component = component
    }

    public var body: some View {
         VSplitView {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
    }
}
