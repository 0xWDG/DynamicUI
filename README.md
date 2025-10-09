# DynamicUI

Create a SwiftUI user interface through a JSON file. The JSON file will contain the structure of the user interface, and the program will create the user interface based on the JSON file.

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2F0xWDG%2FDynamicUI%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/0xWDG/DynamicUI) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2F0xWDG%2FDynamicUI%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/0xWDG/DynamicUI)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
![License](https://img.shields.io/github/license/0xWDG/Inspect)

## Requirements

- Swift 5.9+ (Xcode 15+)
- iOS 15+, macOS 12+, tvOS 14+, watchOS 7+, macCatalyst 15+, visionOS 1.0+

## Installation

Install using Swift Package Manager

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
    """.data(using: .utf8)

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

## Usage (Legacy)

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
    """.data(using: .utf8)

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

### Playground Application:

In the directory `Playground` is a Xcode project to build the [Playground Application](#Playground)
The playground application is available for macOS, iOS, watchOS, tvOS and visionOS.

## Supported SwiftUI Views

See the list in the [documentation over here](https://0xwdg.github.io/DynamicUI)

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
