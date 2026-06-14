# ``DynamicUI``

Build SwiftUI interfaces from a JSON component tree.

## Overview

DynamicUI decodes a top-level JSON array into ``DynamicUIComponent`` values and renders each
component as its corresponding SwiftUI view. Components can contain children, apply supported
SwiftUI modifiers, emit interaction updates, and select strings based on another component's
current value.

```swift
import DynamicUI
import SwiftUI

struct ContentView: View {
    @State private var component: DynamicUIComponent?
    @State private var error: Error?

    var body: some View {
        DynamicUI(
            json: """
            [
                {
                    "type": "Toggle",
                    "title": "Show favorite",
                    "identifier": "favorite"
                },
                {
                    "type": "Label",
                    "title": "Favorite",
                    "url": "{$favorite ? star.fill : star}"
                }
            ]
            """,
            component: $component,
            error: $error
        )
    }
}
```

The `component` binding receives the most recently interacted-with component. Its `state`
contains the new value for controls such as toggles, text fields, pickers, and sliders.

## Component Schema

Every object requires a case-sensitive `type`. All other fields are optional and are used only
by components that support them.

| Field | JSON type | Purpose |
| --- | --- | --- |
| `type` | String | SwiftUI view type to render. Unknown types render no view. |
| `title` | String | Label, title, placeholder, or accessibility label, depending on the view. |
| `text` | String | Additional string value available to components. |
| `identifier` | String | Stable key used in interaction updates and conditional expressions. |
| `eventHandler` | String | Application-defined event name returned with the component. |
| `defaultValue` | String, number, Boolean, or object | Initial value for stateful controls. |
| `state` | String, number, Boolean, or object | Current value included in interaction updates. |
| `children` | Array | Nested components rendered by container views. |
| `url` | String | SF Symbol name used by `Image`, `Label`, and tab labels. |
| `disabled` | Boolean | Whether the rendered component is disabled. |
| `modifiers` | Object | Supported visual and behavioral modifiers. See <doc:Modifiers>. |
| `parameters` | Object | Additional application-defined values returned with the component. |
| `minimum`, `maximum` | String | Visible endpoint labels for `Slider`. |
| `minimumValue`, `maximumValue` | Number | Numeric bounds for `Slider`; `maximumValue` is also the total for `ProgressView`. |

> Important: JSON component types and field names are case-sensitive.

## Handle Interactions

Use a component binding when SwiftUI state should retain the latest update:

```swift
DynamicUI(json: json, component: $component, error: $error)
    .onChange(of: component) { component in
        guard let component else { return }
        print(component.identifier as Any, component.state as Any)
    }
```

Alternatively, use the callback initializer:

```swift
DynamicUI(json: json) { component in
    print(component.eventHandler as Any, component.state as Any)
}
```

Buttons emit their component when pressed. `Toggle`, `TextField`, `SecureField`, `TextEditor`,
`Picker`, and `Slider` emit a copy of their component with an updated `state`.

## Conditional Strings

A conditional expression selects one of two strings using the current value of an identified
component:

```json
{
    "type": "Label",
    "title": "{$favorite ? Saved : Not saved}",
    "url": "{$favorite ? star.fill : star}"
}
```

The syntax is `{$identifier ? valueWhenTrue : valueWhenFalse}`. Expressions must occupy the
entire string. They work in `title`, `text`, `url`, `minimum`, `maximum`, and string values nested
in `modifiers` or `parameters`. Missing identifiers and empty, zero, `false`, or `null` values
select the false branch.

## Supported Views

### Content

- <doc:Views/Text>
- <doc:Views/Label>
- <doc:Views/Image>
- <doc:Views/Divider>
- <doc:Views/Spacer>

### Controls

- <doc:Views/Button>
- <doc:Views/Toggle>
- <doc:Views/TextField>
- <doc:Views/SecureField>
- <doc:Views/TextEditor>
- <doc:Views/Picker>
- <doc:Views/Slider>
- <doc:Views/Gauge>
- <doc:Views/ProgressView>

### Containers

- <doc:Views/VStack>
- <doc:Views/HStack>
- <doc:Views/ZStack>
- <doc:Views/Group>
- <doc:Views/GroupBox>
- <doc:Views/DisclosureGroup>
- <doc:Views/List>
- <doc:Views/Form>
- <doc:Views/Section>
- <doc:Views/ScrollView>
- <doc:Views/NavigationView>
- <doc:Views/NavigationSplitView>
- <doc:Views/TabView>
- <doc:Views/HSplitView>
- <doc:Views/VSplitView>

## Platform Behavior

Some views adapt when their SwiftUI equivalent is unavailable:

| Component | Behavior |
| --- | --- |
| `NavigationSplitView` | Uses `NavigationView` before iOS 16, macOS 13, and tvOS 16, and on watchOS. |
| `HSplitView` | Uses `HStack` outside macOS. |
| `VSplitView` | Renders only on macOS. |
| `DisclosureGroup`, `Group`, `GroupBox` | Use `VStack` on tvOS and watchOS. |
| `TextEditor` | Uses `TextField` outside iOS and macOS. |
| `Slider` | Renders no view on tvOS. |
| `Gauge` | Requires iOS 16 or macOS 13 and renders no view on tvOS. |

## Topics

### Essentials

- ``DynamicUI``
- ``DynamicUIComponent``
- ``AnyCodable``

### Styling

- <doc:Modifiers>
