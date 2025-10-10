//
//  DynamicImage.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 19/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI: Image
/// 
/// DynamicImage is a SwiftUI View that can be used to display an image.
/// 
/// JSON Example:
/// ```json
/// {
///    "type": "Image",
///    "url": "systemName"
/// }
/// ```
///
/// - Note: The `url` is the systemName of the image.
///         You can use any systemName from SF Symbols.
///         For more information, see https://developer.apple.com/sf-symbols/
///
/// - Note: This is a internal view, you should not use this directly. \
///         Use ``DynamicUI`` instead.
struct DynamicImage: View {
    @Environment(\.internalDynamicUIEnvironment)
    /// Internal: dynamicUIEnvironment
    private var dynamicUIEnvironment

    /// The component to display
    private let component: DynamicUIComponent

    /// Initialize the DynamicImage
    init(_ component: DynamicUIComponent) {
        self.component = component
    }

    /// Generated body for SwiftUI
    var body: some View {
        Image(systemName: component.url ?? "")
            .accessibilityLabel(component.title ?? "")
            .set(modifiers: component)
    }
}
