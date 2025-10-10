//
//  DynamicHSplitView.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: HSplitView
/// 
/// DynamicHSplitView is a SwiftUI View that can be used to display an HSplitView.
/// JSON Example:
/// ```json
/// {
///    "type": "HSplitView",
///    "children": [ ]
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicHSplitView: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicHSplitView
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
#if os(macOS)
        HSplitView {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
        .set(modifiers: component)

#else
        HStack {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
        .set(modifiers: component)

#endif
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview("HSplitView") {
    let json = """
    [
                {
                    "type": "HSplitView",
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
