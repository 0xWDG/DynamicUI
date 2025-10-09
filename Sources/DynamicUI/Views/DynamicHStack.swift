//
//  DynamicHStack.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: HStack
/// 
/// DynamicHStack is a SwiftUI View that can be used to display an HStack.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "HStack",
///    "children": [ ]
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicHStack: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicHStack
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        HStack {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
        .disabled(component.disabled ?? false)
        .dynamicUIModifiers(component.modifiers)
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview("HStack") {
    let json = """
        [
            {
                "type": "HStack",
                "children": [
                    {
                        "type": "VStack",
                        "children": [
                            {
                                "type": "Text",
                                "title": "Text 1",
                            }
                        ],
                        "padding": true,
                        "modifiers": {
                            "background": "blue"
                        }
                    },
                    {
                        "type": "VStack",
                        "children": [
                            {
                                "type": "Text",
                                "title": "Text 2",
                            }
                        ],
                        "padding": true,
                        "modifiers": {
                            "background": "red"
                        }
                    }
                ]
            }
        ]
    """

    DynamicUI(json: json, component: .constant(nil))
}
#endif
