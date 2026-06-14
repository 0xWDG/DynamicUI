# DynamicUI

Create SwiftUI interfaces from JSON component trees. DynamicUI supports nested layouts,
interactive controls, runtime value updates, conditional strings, and a focused set of SwiftUI
modifiers.

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2F0xWDG%2FDynamicUI%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/0xWDG/DynamicUI) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2F0xWDG%2FDynamicUI%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/0xWDG/DynamicUI)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
![License](https://img.shields.io/github/license/0xWDG/Inspect)

## Requirements

- Swift 5.9+ (Xcode 15+)
- iOS 15+, macOS 12+, tvOS 14+, watchOS 8+, macCatalyst 15+, visionOS 1.0+

## Installation

Add DynamicUI using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/0xWDG/DynamicUI.git", branch: "main"),
],
targets: [
    .target(name: "MyTarget", dependencies: [
        .product(name: "DynamicUI", package: "DynamicUI"),
    ]),
]
```

And import it:

```swift
import DynamicUI
```

## Usage

```swift
import SwiftUI
import DynamicUI

struct ContentView: View {
    let json = """
    [
        {
            "type": "Text",
            "title": "Wait, am i generating views from JSON?",
            "modifiers": {"foregroundStyle":"red","opacity":0.6}
        },
        {
            "type": "Button",
            "title": "Click me",
            "eventHandler": "customHandler"
        },
        {
            "type": "Toggle",
            "title": "Toggle me",
            "identifier": "my.toggle.1"
        }
    ]
    """

    @State private var component: DynamicUIComponent?
    @State private var error: Error?

    var body: some View {
        DynamicUI(
            json: json,
            component: $component,
            error: $error
        )
    }
}
```

Conditional expressions can select a string value using another component's current state:

```json
[
    {
        "type": "Toggle",
        "title": "Toggle me",
        "identifier": "myIdentifier"
    },
    {
        "type": "Label",
        "title": "Shine",
        "url": "{$myIdentifier ? star.fill : star}"
    }
]
```

The syntax is `{$identifier ? valueWhenTrue : valueWhenFalse}`. It works in string-valued
component fields, including `title`, `text`, `url`, modifiers, and parameters.

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
import SwiftUI
import DynamicUI

struct ContentView: View {
    let json = """
    [
        {
            "type": "Text",
            "title": "Wait, am i generating views from JSON?",
            "modifiers": {"foregroundStyle":"red","opacity":0.6}
        },
        {
            "type": "Button",
            "title": "Click me",
            "eventHandler": "customHandler"
        },
        {
            "type": "Toggle",
            "title": "Toggle me",
            "identifier": "my.toggle.1"
        }
    ]
    """

    @State private var error: Error?

    var body: some View {
        DynamicUI(
            json: json,
            callback: { component in
                // This contains everything passed as a component (type, title, identifier, ...)
                print(component)
            },
            error: $error
        )
    }
}
```

## JSON schema

Every component requires a case-sensitive `type`. Common optional fields are:

| Field | Purpose |
| --- | --- |
| `title` | Label, title, placeholder, or accessibility label |
| `identifier` | Stable key for updates and conditional expressions |
| `eventHandler` | Application-defined event name returned on interaction |
| `defaultValue` | Initial value for stateful controls |
| `children` | Nested component array for containers |
| `url` | SF Symbol name for images, labels, and tab labels |
| `disabled` | Disables the component |
| `modifiers` | Visual and behavioral modifiers |
| `minimumValue`, `maximumValue` | Numeric bounds for sliders and progress views |

Unknown component types render no view. Decode failures are written to the optional `error`
binding and display a fallback error view.

## Playground application

The `Playground` directory contains an Xcode project with basic and exhaustive JSON examples. It
is available for macOS, iOS, watchOS, tvOS, and visionOS.

## Supported SwiftUI views

DynamicUI supports content views, controls, layouts, containers, navigation, tabs, and split
views. See the complete schema, platform behavior, component examples, and modifier reference in
the [documentation](https://0xwdg.github.io/DynamicUI).

## Images

### Playground

<a name="Playground">
<img width="804" alt="image" src="https://github.com/user-attachments/assets/cfd7ba02-88b1-410d-a6ba-54c9ebee06e0">

### V0.0.1 in action

<img width="835" alt="image" src="https://github.com/0xWDG/DynamicUI/assets/1290461/02e2d735-5496-4b68-a428-9e03815bf4d6">

## Used By

- [Aurora Editor](https://github.com/AuroraEditor/AuroraEditor) for custom views in extensions.

## Contact

🦋 [@0xWDG](https://bsky.app/profile/0xWDG.bsky.social)
🐘 [mastodon.social/@0xWDG](https://mastodon.social/@0xWDG)
🐦 [@0xWDG](https://x.com/0xWDG)
🧵 [@0xWDG](https://www.threads.net/@0xWDG)
🌐 [wesleydegroot.nl](https://wesleydegroot.nl)
🤖 [Discord](https://discordapp.com/users/918438083861573692)
