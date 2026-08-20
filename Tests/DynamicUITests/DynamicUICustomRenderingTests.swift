//
//  DynamicUICustomRenderingTests.swift
//  DynamicUITests
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI
import XCTest
@testable import DynamicUI

final class DynamicUICustomRenderingTests: XCTestCase {
    func testCustomRendererReceivesUnknownComponent() throws {
        let json = #"[{"type":"ProductCard","title":"Keyboard"}]"#
        let dynamicUI = DynamicUI(
            json: json,
            component: .constant(nil),
            customViewRenderer: { component in
                AnyView(Text(component.title ?? component.type))
            }
        )
        let component = try XCTUnwrap(DynamicUILayout(json: json).components.first)

        XCTAssertNotNil(dynamicUI.customViewRenderer?(component))
    }
}
