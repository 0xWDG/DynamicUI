//
//  DynamicDivider.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Divider
/// 
/// DynamicDivider is a SwiftUI View that can be used to display an Divider.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "Divider"
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicDivider: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicDivider
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        Divider()
            .dynamicUIModifiers(component.modifiers)
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview("Section") {
    let json = """
        [
            {
                "type": "VStack",
                "children": [
                    {
                        "type": "Text",
                        "title": "Divider",
                        "modifiers": {
                            "foregroundColor": "purple"
                        }
                    },
                    {
                        "type": "Divider",
                        "modifiers": {
                            "foregroundColor": "purple"
                        }
                    }
                ]
            }
        ]
    """

    DynamicUI(json: json, component: .constant(nil))
}
#endif
