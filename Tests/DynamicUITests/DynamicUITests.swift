import XCTest
@testable import DynamicUI

final class DynamicUITests: XCTestCase {
    func testSupportedViewRegistryContainsEveryDocumentedView() {
        let expectedTypes: Set<String> = [
            "AsyncImage", "Button", "ColorPicker", "DatePicker", "DisclosureGroup", "Divider",
            "Form", "Gauge", "Grid", "GridRow", "Group", "GroupBox", "HSplitView", "HStack",
            "Image", "Label", "LazyHGrid", "LazyHStack", "LazyVGrid", "LazyVStack", "Link",
            "List", "Menu", "NavigationLink", "NavigationSplitView", "NavigationStack",
            "NavigationView", "Picker", "ProgressView", "ScrollView", "Section", "SecureField",
            "ShareLink", "Slider", "Spacer", "Stepper", "TabView", "Text", "TextEditor",
            "TextField", "Toggle", "VSplitView", "VStack", "ZStack"
        ]

        XCTAssertEqual(Set(DynamicUIViewType.allCases.map(\.rawValue)), expectedTypes)
    }

    func testLayoutDecoderIgnoresMetadataEntriesWithoutType() throws {
        let json = """
            [
                { "test": true, "comment": "This should be ignored and not fail" },
                { "type": "Text", "title": "Visible" }
            ]
            """

        let components = try DynamicUILayoutDecoder.decode(from: Data(json.utf8))

        XCTAssertEqual(components.count, 1)
        XCTAssertEqual(components.first?.type, "Text")
        XCTAssertEqual(components.first?.title, "Visible")
    }

    func testComponentDecoderIgnoresNestedMetadataEntriesWithoutType() throws {
        let json = """
            {
                "type": "VStack",
                "children": [
                    { "comment": "This should be ignored" },
                    { "type": "Text", "title": "Visible child" }
                ]
            }
            """

        let component = try JSONDecoder().decode(
            DynamicUIComponent.self,
            from: Data(json.utf8)
        )

        XCTAssertEqual(component.children?.count, 1)
        XCTAssertEqual(component.children?.first?.title, "Visible child")
    }

    func testTypedComponentsStillReportMalformedFields() {
        let json = #"[{"type":"Text","disabled":"not-a-boolean"}]"#

        XCTAssertThrowsError(
            try DynamicUILayoutDecoder.decode(from: Data(json.utf8))
        )
    }

    func testAnyCodableRoundTripsNaturalJSONValues() throws {
        let json = """
            {
                "string": "value",
                "int": 42,
                "double": 4.5,
                "bool": true,
                "dictionary": {
                    "nested": "value"
                },
                "none": null
            }
            """
        let data = Data(json.utf8)

        let decoded = try JSONDecoder().decode([String: AnyCodable].self, from: data)
        let encoded = try JSONEncoder().encode(decoded)
        let roundTripped = try JSONDecoder().decode([String: AnyCodable].self, from: encoded)

        XCTAssertEqual(roundTripped, decoded)
    }

    func testComponentDecodesNestedChildrenAndModifiers() throws {
        let json = """
            {
                "type": "VStack",
                "modifiers": {
                    "padding": true
                },
                "children": [
                    {
                        "type": "Text",
                        "title": "Hello"
                    }
                ]
            }
            """

        let component = try JSONDecoder().decode(
            DynamicUIComponent.self,
            from: Data(json.utf8)
        )

        XCTAssertEqual(component.type, "VStack")
        XCTAssertEqual(component.modifiers?["padding"], .bool(true))
        XCTAssertEqual(component.children?.first?.title, "Hello")

        let encoded = try JSONEncoder().encode(component)
        let roundTripped = try JSONDecoder().decode(DynamicUIComponent.self, from: encoded)
        XCTAssertEqual(roundTripped, component)
    }

    func testIntegerConvertsToDoubleForNumericModifiers() {
        XCTAssertEqual(AnyCodable.int(16).toDouble(), 16)
    }

    func testNewContainerComponentsDecodeTheirChildren() throws {
        let json = """
            [
                {
                    "type": "TabView",
                    "children": [
                        {
                            "type": "Text",
                            "title": "First tab"
                        }
                    ]
                },
                {
                    "type": "NavigationSplitView",
                    "children": [
                        {
                            "type": "Text",
                            "title": "Sidebar"
                        },
                        {
                            "type": "Text",
                            "title": "Detail"
                        }
                    ]
                }
            ]
            """

        let components = try JSONDecoder().decode(
            [DynamicUIComponent].self,
            from: Data(json.utf8)
        )

        XCTAssertEqual(components[0].type, "TabView")
        XCTAssertEqual(components[0].children?.count, 1)
        XCTAssertEqual(components[1].type, "NavigationSplitView")
        XCTAssertEqual(components[1].children?.count, 2)
    }

    func testConditionalExpressionSelectsValueUsingIdentifierState() {
        let expression = "{$myIdentifier ? star.fill : star}"

        XCTAssertEqual(
            DynamicUIExpression.resolve(expression, values: ["myIdentifier": .bool(true)]),
            "star.fill"
        )
        XCTAssertEqual(
            DynamicUIExpression.resolve(expression, values: ["myIdentifier": .bool(false)]),
            "star"
        )
    }

    func testConditionalExpressionDefaultsToFalseValueForMissingIdentifier() {
        XCTAssertEqual(
            DynamicUIExpression.resolve("{$missing ? Visible : Hidden}", values: [:]),
            "Hidden"
        )
    }

    func testComponentConditionUsesIdentifierState() throws {
        let json = """
            {
                "type": "Text",
                "title": "Conditional view",
                "if": "$myIdentifier"
            }
            """
        let component = try JSONDecoder().decode(
            DynamicUIComponent.self,
            from: Data(json.utf8)
        )

        XCTAssertEqual(component.condition, "$myIdentifier")
        XCTAssertTrue(component.shouldRender(values: ["myIdentifier": .bool(true)]))
        XCTAssertFalse(component.shouldRender(values: ["myIdentifier": .bool(false)]))
        XCTAssertFalse(component.shouldRender(values: [:]))

        let encoded = try JSONEncoder().encode(component)
        let roundTripped = try JSONDecoder().decode(DynamicUIComponent.self, from: encoded)
        XCTAssertEqual(roundTripped.condition, "$myIdentifier")
    }

    func testComponentWithoutConditionRenders() throws {
        let json = #"{"type":"Text","title":"Always visible"}"#
        let component = try JSONDecoder().decode(
            DynamicUIComponent.self,
            from: Data(json.utf8)
        )

        XCTAssertTrue(component.shouldRender(values: [:]))
    }

    func testComponentResolvesConditionalStringsRecursively() throws {
        let json = """
            {
                "type": "Label",
                "title": "{$myIdentifier ? Shine : Dim}",
                "url": "{$myIdentifier ? star.fill : star}"
            }
            """
        let component = try JSONDecoder().decode(
            DynamicUIComponent.self,
            from: Data(json.utf8)
        )

        let resolved = component.resolvingStrings(values: ["myIdentifier": .bool(true)])

        XCTAssertEqual(resolved.title, "Shine")
        XCTAssertEqual(resolved.url, "star.fill")
    }

}
