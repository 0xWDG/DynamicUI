# DynamicUI

Render server-driven SwiftUI interfaces from JSON across Apple platforms.

DynamicUI turns versioned JSON component trees into native SwiftUI views. Use it for remote forms,
configurable extension interfaces, feature-driven layouts, and rapid prototypes without giving up
native controls or accessibility semantics.

[![Supported Swift versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2F0xWDG%2FDynamicUI%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/0xWDG/DynamicUI)
[![Supported platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2F0xWDG%2FDynamicUI%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/0xWDG/DynamicUI)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
[![Run tests on macOS](https://github.com/0xWDG/DynamicUI/actions/workflows/test-macOS.yml/badge.svg)](https://github.com/0xWDG/DynamicUI/actions/workflows/test-macOS.yml)
[![Run tests on iOS](https://github.com/0xWDG/DynamicUI/actions/workflows/build-iOS.yml/badge.svg)](https://github.com/0xWDG/DynamicUI/actions/workflows/build-iOS.yml)
[![Run tests on visionOS](https://github.com/0xWDG/DynamicUI/actions/workflows/build-visionOS.yml/badge.svg)](https://github.com/0xWDG/DynamicUI/actions/workflows/build-visionOS.yml)
[![Run tests on Apple TV](https://github.com/0xWDG/DynamicUI/actions/workflows/build-tvOS.yml/badge.svg)](https://github.com/0xWDG/DynamicUI/actions/workflows/build-tvOS.yml)
[![Run tests on Watch OS](https://github.com/0xWDG/DynamicUI/actions/workflows/build-watchOS.yml/badge.svg)](https://github.com/0xWDG/DynamicUI/actions/workflows/build-watchOS.yml)
[![License](https://img.shields.io/github/license/0xWDG/DynamicUI)](LICENCE.md)

<img width="804" alt="DynamicUI playground rendering a JSON-defined SwiftUI interface" src="https://github.com/user-attachments/assets/cfd7ba02-88b1-410d-a6ba-54c9ebee06e0">

## Why DynamicUI?

- Native SwiftUI views on iOS, macOS, tvOS, watchOS, Mac Catalyst, and visionOS.
- Nested layouts, interactive controls, conditional content, and runtime value updates.
- Versioned schemas with validation before rendering.
- Application-defined components through a custom renderer.
- Explicit VoiceOver, Voice Control, and UI-test metadata in JSON.

## Requirements

- Swift 5.9+ (Xcode 15+)
- iOS 15+, macOS 12+, tvOS 14+, watchOS 8+, Mac Catalyst 15+, visionOS 1.0+

## Installation

Add DynamicUI using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/0xWDG/DynamicUI.git", exact: "0.1.1"),
],
targets: [
    .target(name: "MyTarget", dependencies: [
        .product(name: "DynamicUI", package: "DynamicUI"),
    ]),
]
```

In Xcode, select **File → Add Package Dependencies**, enter
`https://github.com/0xWDG/DynamicUI`, and choose version `0.1.1`.

Then import the package:

```swift
import DynamicUI
```

## Quick start

```swift
import SwiftUI
import DynamicUI

struct ContentView: View {
    let json = """
    [
        {
            "type": "Text",
            "title": "This interface comes from JSON",
            "modifiers": {"foregroundStyle":"red","opacity":0.6}
        },
        {
            "type": "Button",
            "title": "Continue",
            "eventHandler": "continue"
        },
        {
            "type": "Toggle",
            "title": "Show details",
            "identifier": "showDetails"
        }
    ]
    """

    @State private var component: DynamicUIComponent?
    @State private var error: Error?

    var body: some View {
        DynamicUI(json: json, component: $component, error: $error)
    }
}
```

## Versioned layouts and validation

For production payloads, use the versioned layout envelope:

```json
{
    "schemaVersion": 1,
    "components": [
        { "type": "Text", "title": "A validated layout" }
    ]
}
```

Legacy top-level component arrays remain supported. Validate either representation before
rendering with `try DynamicUILayout(json: json)`. Validation rejects unsupported schema versions,
empty types and identifiers, duplicate identifiers, and malformed component conditions.

## Conditional content

Conditional expressions can select strings or control whether an entire component renders:

```json
[
    {
        "type": "Toggle",
        "title": "Show favorite",
        "identifier": "favorite"
    },
    {
        "type": "Label",
        "title": "{$favorite ? Saved : Not saved}",
        "url": "{$favorite ? star.fill : star}"
    },
    {
        "type": "Text",
        "title": "The favorite is enabled",
        "if": "$favorite"
    }
]
```

The string syntax is `{$identifier ? valueWhenTrue : valueWhenFalse}`. Missing identifiers and
empty, zero, `false`, or `null` values select the false branch and hide conditional views.

## Handle interactions

The `component` binding receives the latest interacted-with component. Stateful controls include
their new value in `state`; `identifier` and `eventHandler` let your application route the update.

```swift
.onChange(of: component) { component in
    guard let component else { return }

    print(component.identifier as Any)
    print(component.eventHandler as Any)
    print(component.state as Any)
}
```

You can use a callback instead of a binding:

```swift
DynamicUI(json: json) { component in
    print(component.eventHandler as Any, component.state as Any)
}
```

## Custom components

Render application-specific component types without forking DynamicUI. Return `nil` for component
types your renderer does not recognize:

```swift
DynamicUI(
    json: json,
    component: $component,
    error: $error,
    customViewRenderer: { component in
        guard component.type == "ProductCard" else { return nil }

        return AnyView(
            ProductCard(
                title: component.title ?? "Product",
                productID: component.parameters?["productID"]?.toString()
            )
        )
    }
)
```

DynamicUI applies supported modifiers and accessibility metadata to the custom view. Unknown types
that neither DynamicUI nor the application recognizes are logged and skipped.

## Accessibility

DynamicUI uses native SwiftUI controls and supports explicit assistive-technology metadata:

```json
{
    "type": "Button",
    "title": "Save",
    "accessibilityLabel": "Save profile",
    "accessibilityHint": "Saves your profile changes",
    "accessibilityValue": "Ready",
    "accessibilityIdentifier": "profile.save",
    "accessibilityInputLabels": ["Save", "Save profile"]
}
```

Use `accessibilityHidden: true` only for decorative content. Visible control titles continue to
provide native semantics when explicit accessibility metadata is not needed. Accessibility string
fields support the same conditional expressions as visible strings.

## JSON schema

Every component requires a case-sensitive `type`. Common optional fields are:

| Field | Purpose |
| --- | --- |
| `title` | Label, title, placeholder, or image description |
| `if` | Identifier condition such as `$showDetails` that controls rendering |
| `identifier` | Stable key for updates and conditional expressions |
| `eventHandler` | Application-defined event name returned on interaction |
| `defaultValue` | Initial value for stateful controls |
| `children` | Nested component array for containers |
| `url` | SF Symbol name or URL, depending on the component |
| `disabled` | Disables the component |
| `modifiers` | Visual and behavioral modifiers |
| `minimumValue`, `maximumValue` | Numeric bounds for sliders and progress views |
| `accessibilityLabel` | Concise, speakable name for assistive technologies |
| `accessibilityHint` | Describes the result of interacting with the component |
| `accessibilityValue` | Accessible state or formatted value |
| `accessibilityIdentifier` | Stable identifier for UI automation |
| `accessibilityHidden` | Hides decorative content from assistive technologies |
| `accessibilityInputLabels` | Alternative spoken names for Voice Control |

Unknown component types are logged and skipped, allowing valid sibling components to keep
rendering. Decode and validation failures are written to the optional `error` binding and display a
fallback error view. Objects without a string `type` field are treated as metadata and ignored in
component arrays.

## Playground and documentation

The `Playground` directory contains an Xcode project with basic and exhaustive JSON examples for
macOS, iOS, watchOS, tvOS, and visionOS.

See the complete schema, platform behavior, component examples, and modifier reference in the
[documentation](https://0xwdg.github.io/DynamicUI).

## Used By

- [Aurora Editor](https://github.com/AuroraEditor/AuroraEditor) for custom views in extensions.

Using DynamicUI in your project? Open a pull request to add it here.

## Contributing

Issues and pull requests are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for setup, testing,
and contribution guidance, or browse the
[`good first issue`](https://github.com/0xWDG/DynamicUI/labels/good%20first%20issue) label.

## Contact

🦋 [@0xWDG](https://bsky.app/profile/0xWDG.bsky.social)
🐘 [mastodon.social/@0xWDG](https://mastodon.social/@0xWDG)
🐦 [@0xWDG](https://x.com/0xWDG)
🧵 [@0xWDG](https://www.threads.net/@0xWDG)
🌐 [wesleydegroot.nl](https://wesleydegroot.nl)
🤖 [Discord](https://discordapp.com/users/918438083861573692)
