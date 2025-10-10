//
//  DynamicUIComponent.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 16/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// This struct constructs a UI Component from JSON.
public struct DynamicUIComponent: Codable, Hashable {
    /// Type of component
    ///
    /// This is the evaqulent of a SwiftUI View
    public let type: String

    /// Title/Label of component
    public let title: String?

    /// Text within component (if any)
    public let text: String?

    /// Component identifier
    ///
    /// The component identifier can be used to have an identifier if you need react on callback calls
    /// This is optional but recommended if you use a event handler function
    public let identifier: String?

    /// Event handler
    /// 
    /// The event handler is called when the component is interacted with.
    /// This can be a button press, a slider change, etc.
    public let eventHandler: String?

    /// Default value of component
    public let defaultValue: AnyCodable?

    /// Modifiers to components (not yet used)
    public let modifiers: [String: AnyCodable]?

    /// Parameters of component (not yet used)
    public let parameters: [String: AnyCodable]?

    /// URL
    public let url: String?

    /// Children (used in VStack, HStack, ZStack)
    public let children: [DynamicUIComponent]?

    // TODO: Find a way to move this to parameters
    /// Minimum value description
    ///
    /// - Note: This may be removed in the future in favor of ``UIComponent.parameters``
    public let minimum: String?

    // TODO: Find a way to move this to parameters
    /// Minumum value
    ///
    /// - Note: This may be removed in the future in favor of ``UIComponent.parameters``
    public let minimumValue: Double?

    // TODO: Find a way to move this to parameters
    /// Maximum value description
    ///
    /// - Note: This may be removed in the future in favor of ``UIComponent.parameters``
    public let maximum: String?

    // TODO: Find a way to move this to parameters
    /// Maximum value
    ///
    /// - Note: This may be removed in the future in favor of ``UIComponent.parameters``
    public let maximumValue: Double?

    /// Is the component disabled?
    public var disabled: Bool? = false

    /// The current state of an element
    ///
    /// The state can mean the state (on/off), but in case of a text field it can also mean the value of the text field.
    ///
    /// - Note: Do not init state in your UIComponent unless needed.
    public var state: AnyCodable?
}
