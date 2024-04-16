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
    let type: String
    let text: String?
    let title: String?
    let defaultValue: AnyCodable?
    let styling: [[String: AnyCodable]]?
    let imageURL: String?
    let children: [UIComponent]?
}
