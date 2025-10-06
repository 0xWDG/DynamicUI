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

/// DynamicUI: Label
///
/// DynamicLabel is a SwiftUI View that can be used to display an Label.
///
/// JSON Example:
/// ```json
/// {
///    "type": "Label",
///    "title": "Title"
/// }
/// ```
///
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicLabel: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicLabel
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        if let systemImage = component.imageURL {
            Label(
                component.title ?? "Label",
                systemImage: systemImage
            )
            .dynamicUIModifiers(component.modifiers)
        } else {
            DynamicText(component)
                .dynamicUIModifiers(component.modifiers)
        }
    }
}
