//
//  DynamicSecureField.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: DynamicSecureField
/// DynamicSecureField is a SwiftUI View that can be used to display an SecureField.
struct DynamicSecureField: View {
    @State private var state: String
    private let component: UIComponent

    init(_ component: UIComponent) {
        self.state = component.defaultValue?.toString() ?? ""
        self.component = component
    }

    public var body: some View {
        SecureField(
            "\(component.title ?? "")",
            text: $state
        )
    }
}
