//
//  DynamicList.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: List
/// 
/// DynamicList is a SwiftUI View that can be used to display an List.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "List",
///    "children": [ ]
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicList: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicList
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        List {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
        .dynamicUIModifiers(component.modifiers)
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview("Section") {
    let json = """
        [
            {
                "type": "List",
                "children": [
                    {
                        "type": "Section",
                        "title": "List example",
                        "children": [
                            {
                                "type": "Text",
                                "title": "This is inside a list"
                            }
                        ]
                    },
                    {
                        "type": "Section",
                        "children": [
                            {
                                "type": "Text",
                                "title": "This is inside a list"
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
