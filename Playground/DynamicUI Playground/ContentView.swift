//
//  ContentView.swift
//  DynamicUI Playground
//
//  Created by Wesley de Groot on 18/07/2024.
//

import SwiftUI
import DynamicUI

struct ContentView: View {
    @State
    var text: String = """
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
                        "identifier": "my.toggle.1"
                    },
                    {
                        "type": "Text",
                        "title": "_Wait_, am i generating views from JSON?",
                        "modifiers": {
                            "foregroundStyle": "red",
                            "opacity": 0.5
                        },
                    },
                    {
                        "type": "Label",
                        "title": "Shine",
                        "url": "star"
                    }
                ]
            }
            ]
        }
    ]
    """

    @State
    private var log: String = "\n\n\n"

    @State
    private var component: DynamicUIComponent?

    @State
    private var error: Error?

    var body: some View {
        VStack(spacing: 1) {
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
            log = "\(component)"
        }
    }
}

#Preview {
    ContentView()
}
