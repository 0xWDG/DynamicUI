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
    private var data = Date.now

    @State
    var text: String = """
    [
        {
            "type": "VStack",
            "children": [
            {
                "type": "Button",
                "title": "Click me"
            },
            {
                "type": "Toggle",
                "title": "Toggle me"
            },
            {
                "type": "Text",
                "title": "_Wait_, am i generating views from JSON?"
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
    private var log: String = "\n\n\n"

    var body: some View {
        VStack {
            HStack {
                TextEditor(text: $text)
                    .frame(width: 250, height: 450)

                Divider()

                DynamicUI(
                    json: $text.wrappedValue,
                    callback: { component in
                        log = "\(component)"
                    })
                    .frame(minWidth: 350, minHeight: 450)
                    .id(data)
            }
            Divider()
            Text(log)
                .frame(
                    maxWidth: .infinity,
                    minHeight: 50
                )
        }
        .onChange(of: text) {
            data = Date.now
        }
        .frame(width: 500, height: 510)
    }
}

#Preview {
    ContentView()
}
