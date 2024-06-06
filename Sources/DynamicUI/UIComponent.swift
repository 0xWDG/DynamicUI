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
public struct UIComponent: Codable, Hashable {
    /// Type of component
    public let type: String

    /// Text within component
    public let text: String?

    /// Title of component
    public let title: String?

    /// Default value of component
    public let defaultValue: AnyCodable?

    /// Styling of components (not yet used)
    public let styling: [[String: AnyCodable]]?

    /// Parameters of component (not yet used)
    public let parameters: [[String: AnyCodable]]?

    /// Image URL
    public let imageURL: String?

    /// Children (used in VStack, HStack, ZStack)
    public let children: [UIComponent]?

    /// Minumum value description
    public let minumum: String?

    /// Minumum value
    public let minimumValue: Double?

    /// Maximum value description
    public let maximum: String?

    /// Maximum value
    public let maximumValue: Double?
}
