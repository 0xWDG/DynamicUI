//
//  DynamicTextEditor.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: DynamicTextEditor
/// DynamicTextEditor is a SwiftUI View that can be used to display an TextEditor.
struct DynamicTextEditor: View {
    @State private var state: String
    private let component: UIComponent

    init(_ component: UIComponent) {
        self.state = component.defaultValue?.toString() ?? ""
        self.component = component
    }

    public var body: some View {
        TextEditor(text: $state)
    }
}
