# DynamicUI

Create a SwiftUI user interface through a JSON file. The JSON file will contain the structure of the user interface, and the program will create the user interface based on the JSON file.

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2F0xWDG%2FDynamicUI%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/0xWDG/DynamicUI) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2F0xWDG%2FDynamicUI%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/0xWDG/DynamicUI)

> [!WARNING]
>
> This is a work in progress and not yet ready for production use. \
> Please feel free to contribute, report issues, or request features.

## Requirements

- Swift 5.9+ (Xcode 15+)
- iOS 15+, macOS 12+, tvOS 14+, watchOS 7+, macCatalyst 15+, visionOS 1.0+

## Installation

Install using Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/0xWDG/DynamicUI.git", .branch("main")),
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

    var body: some View {
        DynamicUI(
            json: json,
            callback: { component in
                // This contains everything passed as a component (type, title, identifier, ...)
                print(component)
            }
        )
    }
}
```

### Playground Application:

In the directory `Playground` is a Xcode project to build the [Playground Application](#Playground)

### Supported View Types:

_Please note:_ Items prefixed with ⚠ may ignore passed parameters.  
Items <s>with a strikethrough</s> are not yet supported.

<details>
<summary>VStack</summary>

```JSON
{
    "type": "VStack",
    "children": [  ]
}
```

</details>

<details>
<summary>HStack</summary>

```JSON
{
    "type": "HStack",
    "children": [  ]
}
```

</details>

<details>
<summary>ZStack</summary>

```JSON
{
    "type": "ZStack",
    "children": [  ]
}
```

</details>

<details>
<summary>List</summary>

```JSON
{
    "type": "List",
    "children": [  ]
}
```

</details>

<details>
<summary>ScrollView</summary>

```JSON
{
    "type": "ScrollView",
    "children": [  ]
}
```

</details>

<details>
<summary>NavigationView</summary>

```JSON
{
    "type": "NavigationView",
    "children": [  ]
}
```

</details>

<details>
<summary>Form</summary>

```JSON
{
    "type": "Form",
    "children": [  ]
}
```

</details>

<details>
<summary>Button</summary>

```JSON
{
    "type": "Button",
    "title": "Click me!"
}
```

</details>

<details>
<summary>Text</summary>

```JSON
{
    "type": "Text",
    "title": "..."
}
```

</details>

<details>
<summary>Image</summary>

```JSON
{
    "type": "Image",
    "imageURL": "systemName"
}
```

</details>

<details>
<summary>Divider</summary>

```JSON
{
    "type": "Divider"
}
```

</details>

<details>
<summary>Spacer</summary>

```JSON
{
    "type": "Spacer"
}
```

</details>

<details>
<summary>Label</summary>

```JSON
{
    "type": "Label",
    "title": "..."
}
```

</details>

<details>
<summary>TextField</summary>

```JSON
{
    "type": "TextField",
    "title": "...",
    "defaultValue": "..."
}
```

</details>

<details>
<summary>SecureField</summary>

```JSON
{
    "type": "SecureField",
    "title": "...",
    "defaultValue": "..."
}
```

</details>

<details>
<summary>TextEditor</summary>

```JSON
{
    "type": "TextEditor",
    "title": "...",
    "defaultValue": "..."
}
```

</details>

<details>
<summary>Toggle</summary>

```JSON
{
    "type": "Toggle",
    "title": "Turn me on!",
    "defaultValue": true
}
```

</details>

<details>
<summary>⚠ Gauge</summary>

```JSON
{
    "type": "Gauge",
    "title": "...",
    "defaultValue": 0.5
}
```

</details>

<details>
<summary>⚠ ProgressView</summary>

```JSON
{
    "type": "ProgressView",
    "title": "...",
    "value": 50,
    "total": 100
}
```

</details>

<details>
<summary>Slider</summary>

```JSON
{
    "type": "Slider",
    "title": "...",
    "minLabel": "min",
    "maxLabel": "max"
}
```

</details>

<details>
<summary>GroupBox</summary>

```JSON
{
    "type": "GroupBox",
    "children": [ ]
}
```

</details>

<details>
<summary>DisclosureGroup</summary>

```JSON
{
    "type": "DisclosureGroup",
    "children": [ ]
}
```

</details>

<details>
<summary>HSplitView</summary>

```JSON
{
    "type": "HSplitView",
    "children": [ ]
}
```

</details>

<details>
<summary>VSplitView</summary>

```JSON
{
    "type": "VSplitView",
    "children": [ ]
}
```

</details>

<details>
<summary>⚠ Picker</summary>

```JSON
{
    "type": "Picker",
    "title": "...",
    "values": ["...", "..."]
}
```

</details>

<details>
<summary><s>⚠ NavigationSplitView</s></summary>

```JSON
{
    "type": "NavigationSplitView",
    "children": [ ]
}
```

</details>

<details>
<summary><s>⚠ TabView</s></summary>

```JSON
{
    "type": "TabView",
    "children": [ ]
}
```

</details>

## Images

### Playground

<a name="Playground">
<img width="804" alt="image" src="https://github.com/user-attachments/assets/cfd7ba02-88b1-410d-a6ba-54c9ebee06e0">

### V0.0.1 in action

<img width="835" alt="image" src="https://github.com/0xWDG/DynamicUI/assets/1290461/02e2d735-5496-4b68-a428-9e03815bf4d6">

## Used By

- [Aurora Editor](https://github.com/AuroraEditor/AuroraEditor) for custom views in extensions.

## Contact

We can get in touch via [Twitter/X](https://twitter.com/0xWDG), [Discord](https://discordapp.com/users/918438083861573692), [Mastodon](https://mastodon.social/@0xWDG), [Email](mailto:email+oss@wesleydegroot.nl), [Website](https://wesleydegroot.nl).
