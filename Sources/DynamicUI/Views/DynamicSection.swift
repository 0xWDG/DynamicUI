//
//  DynamicTEMPLATE.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Section
/// 
/// DynamicSection is a SwiftUI View that can be used to display an Section.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "Section",
///    "title": "Title"
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicSection: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    @State
    /// The state of the Section
    private var state: Double

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicSection
    init(_ component: DynamicUIComponent) {
        self.state = component.defaultValue?.toDouble() ?? 0
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        if let title = component.title, !title.isEmpty {
            Section(header: Text(title)) {
                if let children = component.children {
                    AnyView(dynamicUIEnvironment.buildView(for: children))
                }
            }
            .dynamicUIModifiers(component.modifiers)
        } else {
            Section {
                if let children = component.children {
                    AnyView(dynamicUIEnvironment.buildView(for: children))
                }
            }
            .dynamicUIModifiers(component.modifiers)
        }
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview("Section") {
    let json = """
        [
            {
                "type": "Form",
                "children": [
                    {
                        "type": "Section",
                        "title": "Form example",
                        "children": [
                            {
                                "type": "Text",
                                "title": "This is inside a form"
                            }
                        ]
                    },
                    {
                        "type": "Section",
                        "children": [
                            {
                                "type": "Text",
                                "title": "This is inside a form"
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
