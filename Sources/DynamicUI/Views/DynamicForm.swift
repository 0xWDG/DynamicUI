//
//  DynamicForm.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Form
///
/// DynamicForm is a SwiftUI View that can be used to display an Form.
///
/// JSON Example:
/// ```json
/// {
///    "type": "Form",
///    "children": [ ]
/// }
/// ```
/// 
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicForm: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicForm
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        Form {
            if let children = component.children {
                AnyView(dynamicUIEnvironment.buildView(for: children))
            }
        }
        .set(modifiers: component)
    }
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
#Preview("Form") {
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
