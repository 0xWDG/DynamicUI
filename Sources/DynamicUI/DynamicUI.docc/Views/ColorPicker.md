# ColorPicker Example

```json
[
    {
        "type": "ColorPicker",
        "title": "Accent color",
        "identifier": "accent",
        "defaultValue": "#3366FFFF",
        "parameters": {
            "supportsOpacity": true
        }
    }
]
```

Changes emit an eight-digit `#RRGGBBAA` hexadecimal string in `state`. ColorPicker renders on iOS
and macOS and is unavailable on tvOS and watchOS.

| Parameter | Type | Description |
| --- | --- | --- |
| `title` | String | Accessible picker label. |
| `identifier` | String | Key used for updates and conditional expressions. |
| `defaultValue` | String | Named color, `#RRGGBB`, or `#RRGGBBAA`. |
| `parameters.supportsOpacity` | Boolean | Whether the picker includes opacity. Defaults to `true`. |
| `modifiers` | Object | Visual and behavioral modifiers. |
