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

/// DynamicUI: ProgressView
/// 
/// DynamicProgressView is a SwiftUI View that can be used to display an progress view.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "ProgressView",
///    "title": "Title",
///    "value": "50",
///    "total": "100"
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead. this function is public to generate documentation.
public struct DynamicProgressView: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicProgressView
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    public var body: some View {
        ProgressView(
            "\(component.title ?? "")",
            value: component.defaultValue?.toDouble() ?? 0,
            total: component.maximumValue ?? 100
        )
    }
}
