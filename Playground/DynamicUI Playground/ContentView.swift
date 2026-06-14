//
//  ContentView.swift
//  DynamicUI Playground
//
//  Created by Wesley de Groot on 18/07/2024.
//

import SwiftUI
import DynamicUI

// swiftlint:disable file_length
struct ContentView: View {
    @State
    private var selectedDemo = Demo.basic

    @State
    private var text = Demo.basic.json

    @State
    private var log: String = "\n\n\n"

    @State
    private var component: DynamicUIComponent?

    @State
    private var error: Error?

    var body: some View {
        VStack(spacing: 1) {
            Picker("Demo", selection: $selectedDemo) {
                ForEach(Demo.allCases) { demo in
                    Text(demo.title)
                        .tag(demo)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            HStack(spacing: 1) {
                TextEditor(text: $text)
                    .frame(maxWidth: .infinity)
                    .border(error == nil ? .green : .red)

                Divider()

                DynamicUI(
                    json: text,
                    component: $component,
                    error: $error
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .id(text) // To update if text is changed
                .border(.purple)
            }
            Divider()
            VStack {
                Text(log)
                    .frame(maxWidth: .infinity)
                    .minimumScaleFactor(0.1)
            }
            .border(.blue)
            .frame(height: 75)
            .frame(maxWidth: .infinity)
        }
        .onChange(of: component) {
            log = String(describing: component)
        }
        .onChange(of: selectedDemo) {
            text = selectedDemo.json
            log = "\n\n\n"
        }
    }
}

// The exhaustive JSON fixture intentionally makes this enum longer than production types.
// swiftlint:disable type_body_length
private enum Demo: String, CaseIterable, Identifiable {
    case basic
    case allSupportedOptions

    var id: Self {
        self
    }

    var title: String {
        switch self {
        case .basic:
            return "Basic"
        case .allSupportedOptions:
            return "All Supported Options"
        }
    }

    var json: String {
        switch self {
        case .basic:
            return Self.basicJSON
        case .allSupportedOptions:
            return Self.allSupportedOptionsJSON
        }
    }

    private static let basicJSON = """
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
                        },
                        {
                            "type": "Button",
                            "title": "Click me",
                            "eventHandler": "customHandler"
                        },
                        {
                            "type": "Toggle",
                            "title": "Toggle me",
                            "identifier": "myIdentifier"
                        },
                        {
                            "type": "Text",
                            "title": "_Wait_, am I generating views from JSON?",
                            "modifiers": {
                                "foregroundStyle": "red",
                                "opacity": 0.5
                            }
                        },
                        {
                            "type": "Label",
                            "title": "Shine",
                            "url": "{$myIdentifier ? star.fill : star}"
                        },
                        {
                            "type": "Label",
                            "title": "{$myIdentifier ? Ready to party : Waiting}",
                            "url": "{$myIdentifier ? balloon.fill : balloon}"
                        }
                    ]
                }
            ]
        }
    ]
    """

    // Every component dispatched by DynamicUI and every implemented modifier is represented here.
    private static let allSupportedOptionsJSON = """
    [
        {
            "type": "TabView",
            "children": [
                {
                    "type": "Form",
                    "title": "Components",
                    "url": "square.grid.2x2",
                    "children": [
                        {
                            "type": "Section",
                            "title": "Content",
                            "children": [
                                {
                                    "type": "Text",
                                    "title": "Text"
                                },
                                {
                                    "type": "Label",
                                    "title": "Label",
                                    "url": "tag"
                                },
                                {
                                    "type": "Image",
                                    "title": "Star image",
                                    "url": "star.fill",
                                    "modifiers": {
                                        "foregroundColor": "yellow"
                                    }
                                },
                                {
                                    "type": "Divider"
                                },
                                {
                                    "type": "HStack",
                                    "children": [
                                        {
                                            "type": "Text",
                                            "title": "Leading"
                                        },
                                        {
                                            "type": "Spacer"
                                        },
                                        {
                                            "type": "Text",
                                            "title": "Trailing"
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            "type": "Section",
                            "title": "Controls",
                            "children": [
                                {
                                    "type": "Button",
                                    "title": "Button",
                                    "identifier": "button",
                                    "eventHandler": "buttonPressed"
                                },
                                {
                                    "type": "Toggle",
                                    "title": "Toggle",
                                    "identifier": "toggle",
                                    "defaultValue": true
                                },
                                {
                                    "type": "TextField",
                                    "title": "Text field",
                                    "identifier": "textField",
                                    "defaultValue": "Editable text"
                                },
                                {
                                    "type": "SecureField",
                                    "title": "Secure field",
                                    "identifier": "secureField",
                                    "defaultValue": "password"
                                },
                                {
                                    "type": "TextEditor",
                                    "identifier": "textEditor",
                                    "defaultValue": "Text editor",
                                    "modifiers": {
                                        "frame": {
                                            "height": 70
                                        }
                                    }
                                },
                                {
                                    "type": "Slider",
                                    "title": "Slider",
                                    "identifier": "slider",
                                    "minimum": "0",
                                    "minimumValue": 0,
                                    "maximum": "100",
                                    "maximumValue": 100,
                                    "defaultValue": 35
                                },
                                {
                                    "type": "Picker",
                                    "title": "Picker",
                                    "identifier": "picker",
                                    "defaultValue": 1,
                                    "children": [
                                        {
                                            "type": "Text",
                                            "title": "First"
                                        },
                                        {
                                            "type": "Text",
                                            "title": "Second"
                                        },
                                        {
                                            "type": "Text",
                                            "title": "Third"
                                        }
                                    ]
                                },
                                {
                                    "type": "ProgressView",
                                    "title": "Progress",
                                    "defaultValue": 0.65,
                                    "maximumValue": 1
                                },
                                {
                                    "type": "Gauge",
                                    "title": "Gauge",
                                    "defaultValue": 0.7
                                },
                                {
                                    "type": "Button",
                                    "title": "Disabled button",
                                    "disabled": true
                                }
                            ]
                        }
                    ]
                },
                {
                    "type": "ScrollView",
                    "title": "Containers",
                    "url": "rectangle.3.group",
                    "children": [
                        {
                            "type": "VStack",
                            "children": [
                                {
                                    "type": "Text",
                                    "title": "VStack",
                                    "modifiers": {
                                        "fontWeight": "bold"
                                    }
                                },
                                {
                                    "type": "HStack",
                                    "children": [
                                        {
                                            "type": "Text",
                                            "title": "HStack"
                                        },
                                        {
                                            "type": "Spacer"
                                        },
                                        {
                                            "type": "Image",
                                            "title": "Stack",
                                            "url": "rectangle.split.3x1"
                                        }
                                    ]
                                },
                                {
                                    "type": "ZStack",
                                    "children": [
                                        {
                                            "type": "Text",
                                            "title": "Background",
                                            "modifiers": {
                                                "backgroundColor": "blue",
                                                "padding": 20
                                            }
                                        },
                                        {
                                            "type": "Text",
                                            "title": "ZStack",
                                            "modifiers": {
                                                "foregroundColor": "white",
                                                "bold": true
                                            }
                                        }
                                    ]
                                },
                                {
                                    "type": "Group",
                                    "children": [
                                        {
                                            "type": "Text",
                                            "title": "Group child one"
                                        },
                                        {
                                            "type": "Text",
                                            "title": "Group child two"
                                        }
                                    ]
                                },
                                {
                                    "type": "GroupBox",
                                    "children": [
                                        {
                                            "type": "Text",
                                            "title": "GroupBox content"
                                        }
                                    ]
                                },
                                {
                                    "type": "DisclosureGroup",
                                    "title": "DisclosureGroup",
                                    "children": [
                                        {
                                            "type": "Text",
                                            "title": "Disclosure content"
                                        }
                                    ]
                                },
                                {
                                    "type": "List",
                                    "children": [
                                        {
                                            "type": "Text",
                                            "title": "List row one"
                                        },
                                        {
                                            "type": "Text",
                                            "title": "List row two"
                                        }
                                    ],
                                    "modifiers": {
                                        "frame": {
                                            "height": 110
                                        }
                                    }
                                },
                                {
                                    "type": "HSplitView",
                                    "children": [
                                        {
                                            "type": "Text",
                                            "title": "Horizontal split one"
                                        },
                                        {
                                            "type": "Text",
                                            "title": "Horizontal split two"
                                        }
                                    ],
                                    "modifiers": {
                                        "frame": {
                                            "height": 50
                                        }
                                    }
                                },
                                {
                                    "type": "VSplitView",
                                    "children": [
                                        {
                                            "type": "Text",
                                            "title": "Vertical split one"
                                        },
                                        {
                                            "type": "Text",
                                            "title": "Vertical split two"
                                        }
                                    ],
                                    "modifiers": {
                                        "frame": {
                                            "height": 80
                                        }
                                    }
                                },
                                {
                                    "type": "NavigationView",
                                    "children": [
                                        {
                                            "type": "Text",
                                            "title": "NavigationView content"
                                        }
                                    ],
                                    "modifiers": {
                                        "frame": {
                                            "height": 80
                                        }
                                    }
                                }
                            ],
                            "modifiers": {
                                "padding": true
                            }
                        }
                    ]
                },
                {
                    "type": "ScrollView",
                    "title": "Modifiers",
                    "url": "paintbrush",
                    "children": [
                        {
                            "type": "VStack",
                            "children": [
                                {
                                    "type": "Text",
                                    "title": "foregroundStyle + background",
                                    "modifiers": {
                                        "foregroundStyle": "white",
                                        "background": "blue",
                                        "padding": true
                                    }
                                },
                                {
                                    "type": "Text",
                                    "title": "color + backgroundStyle",
                                    "modifiers": {
                                        "color": "purple",
                                        "backgroundStyle": "yellow",
                                        "padding": 8
                                    }
                                },
                                {
                                    "type": "Text",
                                    "title": "Text style font",
                                    "modifiers": {
                                        "font": "title2"
                                    }
                                },
                                {
                                    "type": "Text",
                                    "title": "Custom font + weight",
                                    "modifiers": {
                                        "font": {
                                            "size": 20,
                                            "weight": "medium"
                                        },
                                        "fontWeight": "heavy"
                                    }
                                },
                                {
                                    "type": "Text",
                                    "title": "Bold, italic, monospaced",
                                    "modifiers": {
                                        "bold": true,
                                        "italic": true,
                                        "monospaced": true
                                    }
                                },
                                {
                                    "type": "Text",
                                    "title": "Fixed frame",
                                    "modifiers": {
                                        "backgroundColor": "orange",
                                        "frame": {
                                            "width": 180,
                                            "height": 44,
                                            "alignment": "center"
                                        }
                                    }
                                },
                                {
                                    "type": "Text",
                                    "title": "Flexible frame",
                                    "modifiers": {
                                        "backgroundColor": "mint",
                                        "frame": {
                                            "minWidth": 100,
                                            "maxWidth": 300,
                                            "minHeight": 30,
                                            "idealHeight": 44,
                                            "maxHeight": 60,
                                            "alignment": "leading"
                                        }
                                    }
                                },
                                {
                                    "type": "Text",
                                    "title": "Opacity 0.5",
                                    "modifiers": {
                                        "opacity": 0.5
                                    }
                                },
                                {
                                    "type": "Button",
                                    "title": "disabled modifier",
                                    "modifiers": {
                                        "disabled": true
                                    }
                                },
                                {
                                    "type": "Text",
                                    "title": "Per-edge padding",
                                    "modifiers": {
                                        "backgroundColor": "teal",
                                        "padding": {
                                            "top": 4,
                                            "leading": 24,
                                            "bottom": 12,
                                            "trailing": 8
                                        }
                                    }
                                },
                                {
                                    "type": "Text",
                                    "title": "Margin",
                                    "modifiers": {
                                        "backgroundColor": "cyan",
                                        "margin": {
                                            "top": 8,
                                            "leading": 20,
                                            "bottom": 8,
                                            "trailing": 20
                                        }
                                    }
                                },
                                {
                                    "type": "Text",
                                    "title": "Shadow",
                                    "modifiers": {
                                        "backgroundColor": "white",
                                        "padding": 12,
                                        "shadow": {
                                            "color": "black",
                                            "radius": 5,
                                            "x": 0,
                                            "y": 2
                                        }
                                    }
                                }
                            ],
                            "modifiers": {
                                "padding": true
                            }
                        }
                    ]
                },
                {
                    "type": "NavigationSplitView",
                    "title": "Navigation",
                    "url": "sidebar.left",
                    "children": [
                        {
                            "type": "List",
                            "children": [
                                {
                                    "type": "Label",
                                    "title": "Sidebar",
                                    "url": "sidebar.left"
                                }
                            ]
                        },
                        {
                            "type": "VStack",
                            "children": [
                                {
                                    "type": "Text",
                                    "title": "NavigationSplitView detail",
                                    "modifiers": {
                                        "font": "title"
                                    }
                                },
                                {
                                    "type": "Text",
                                    "title": "Conditional expression: {$toggle ? enabled : disabled}"
                                }
                            ],
                            "modifiers": {
                                "padding": true
                            }
                        }
                    ]
                }
            ]
        }
    ]
    """
}
// swiftlint:enable type_body_length

#Preview {
    ContentView()
}
