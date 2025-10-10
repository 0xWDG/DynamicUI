//
//  DynamicSpacer.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Spacer
/// 
/// DynamicSpacer is a SwiftUI View that can be used to display an Spacer.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "Spacer"
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicSpacer: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicSpacer
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        Spacer()
            .set(modifiers: component)
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview("Spacer") {
    let json = """
        [
            {
                "type": "HStack",
                "children": [
                    {
                        "type": "Text",
                        "title": "Left"
                    },
                    {
                        "type": "Spacer"
                    },
                    {
                        "type": "Text",
                        "title": "Right"
                    }
                ],
                "modifiers": {
                    "padding": true
                }
            }
        ]
    """

    DynamicUI(json: json, component: .constant(nil))
}
#endif
