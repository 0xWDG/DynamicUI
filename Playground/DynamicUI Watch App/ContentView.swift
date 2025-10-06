//
//  ContentView.swift
//  DynamicUI Watch App
//
//  Created by Wesley de Groot on 06/10/2025.
//

import SwiftUI
import DynamicUI

struct ContentView: View {
    @State
    var text: String = """
    [
        {
            "type": "VStack",
            "children": [
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
                "imageURL": "star"
            }
            ]
        }
    ]
    """

    @State
    private var component: DynamicUIComponent?

    @State
    private var error: Error?

    @State
    private var log: String = ""

    var body: some View {
        ScrollView {
            DynamicUI(
                json: text,
                component: $component,
                error: $error
            )
            Text("\(String(describing: component))")
        }
    }
}

#Preview {
    ContentView()
}
