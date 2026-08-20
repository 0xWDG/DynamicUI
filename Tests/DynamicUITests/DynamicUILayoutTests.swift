//
//  DynamicUILayoutTests.swift
//  DynamicUITests
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import XCTest
@testable import DynamicUI

final class DynamicUILayoutTests: XCTestCase {
    func testVersionedLayoutEnvelopeDecodesAndValidates() throws {
        let json = """
            {
                "schemaVersion": 1,
                "components": [
                    {
                        "type": "Button",
                        "title": "Save",
                        "identifier": "save",
                        "accessibilityLabel": "Save profile",
                        "accessibilityHint": "Saves your profile changes",
                        "accessibilityValue": "Ready",
                        "accessibilityIdentifier": "profile.save",
                        "accessibilityInputLabels": ["Save", "Save profile"]
                    }
                ]
            }
            """

        let layout = try DynamicUILayout(json: json)

        XCTAssertEqual(layout.schemaVersion, 1)
        XCTAssertEqual(layout.components.first?.accessibilityLabel, "Save profile")
        XCTAssertEqual(layout.components.first?.accessibilityHint, "Saves your profile changes")
        XCTAssertEqual(layout.components.first?.accessibilityValue, "Ready")
        XCTAssertEqual(layout.components.first?.accessibilityIdentifier, "profile.save")
        XCTAssertEqual(layout.components.first?.accessibilityInputLabels, ["Save", "Save profile"])
    }

    func testVersionedLayoutRejectsUnsupportedSchemaVersion() {
        let json = #"{"schemaVersion":2,"components":[]}"#

        XCTAssertThrowsError(try DynamicUILayout(json: json)) { error in
            XCTAssertEqual(
                error as? DynamicUISchemaError,
                .unsupportedSchemaVersion(found: 2, supported: 1)
            )
        }
    }

    func testCodableEntryPointAlsoValidatesSchemaVersion() {
        let json = #"{"schemaVersion":2,"components":[]}"#

        XCTAssertThrowsError(
            try JSONDecoder().decode(DynamicUILayout.self, from: Data(json.utf8))
        ) { error in
            XCTAssertEqual(
                error as? DynamicUISchemaError,
                .unsupportedSchemaVersion(found: 2, supported: 1)
            )
        }
    }

    func testLayoutRejectsDuplicateIdentifiers() {
        let json = """
            [
                { "type": "Toggle", "identifier": "shared" },
                { "type": "TextField", "identifier": "shared" }
            ]
            """

        XCTAssertThrowsError(try DynamicUILayout(json: json)) { error in
            XCTAssertEqual(
                error as? DynamicUISchemaError,
                .duplicateIdentifier("shared", path: "components[1]")
            )
        }
    }

    func testAccessibilityStringsResolveConditions() throws {
        let json = """
            {
                "type": "Image",
                "accessibilityLabel": "{$enabled ? Enabled : Disabled}",
                "accessibilityValue": "{$enabled ? On : Off}",
                "accessibilityInputLabels": ["{$enabled ? Active : Inactive}"]
            }
            """
        let component = try JSONDecoder().decode(DynamicUIComponent.self, from: Data(json.utf8))

        let resolved = component.resolvingStrings(values: ["enabled": .bool(true)])

        XCTAssertEqual(resolved.accessibilityLabel, "Enabled")
        XCTAssertEqual(resolved.accessibilityValue, "On")
        XCTAssertEqual(resolved.accessibilityInputLabels, ["Active"])
    }
}
