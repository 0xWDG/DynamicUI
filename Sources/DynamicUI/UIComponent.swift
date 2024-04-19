//
//  UIComponent.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 16/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// This struct constructs a UI Component from JSON.
struct UIComponent: Codable, Hashable {
    /// Type of component
    let type: String

    /// Text within component
    let text: String?

    /// Title of component
    let title: String?

    /// Default value of component
    let defaultValue: AnyCodable?

    /// Styling of components (not yet used)
    let styling: [[String: AnyCodable]]?

    /// Parameters of component (not yet used)
    let parameters: [[String: AnyCodable]]?

    /// Image URL
    let imageURL: String?

    /// Children (used in VStack, HStack, ZStack)
    let children: [UIComponent]?

    /// Minumum value description
    let minumum: String?

    /// Minumum value
    let minimumValue: Double?

    /// Maximum value description
    let maximum: String?

    /// Maximum value
    let maximumValue: Double?
}
