//
//  DynamicToggle.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 16/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

public struct DynamicToggle: View {
    @State private var state: Bool
    private let title: String

    init(_ component: UIComponent) {
        self.title = component.title ?? ""

        // Since AnyCodable is custom, we need to check the value this way.
        self.state = AnyCodable.bool(value: true) == component.defaultValue
    }

    public var body: some View {
        Toggle(isOn: $state) {
            Text(title)
        }
    }
}
