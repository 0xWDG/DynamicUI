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
///         Use ``DynamicUI`` instead.
struct DynamicProgressView: View {
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
    var body: some View {
        ProgressView(
            "\(component.title ?? "")",
            value: component.defaultValue?.toDouble() ?? 0,
            total: component.maximumValue ?? 1.0
        )
        .disabled(component.disabled ?? false)
        .dynamicUIModifiers(component.modifiers)
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview("ProgressView") {
    let json = """
        [
            {
                "type": "Form",
                "children": [
                    {
                        "type": "Section",
                        "title": "ProgressView example",
                        "children": [
                            {
                                "type": "ProgressView",
                                "title": "ProgressView",
                                "defaultValue": 0.5
                            }
                        ]
                    }
                ]
            }
        ]
    """

    DynamicUI(json: json, component: .constant(nil))
}
#endif
