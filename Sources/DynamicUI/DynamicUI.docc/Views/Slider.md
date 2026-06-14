# Slider

Use a `Slider` for selecting a numeric value within a range.

```json
[
    {
        "type": "Slider",
        "title": "Volume",
        "identifier": "volume",
        "defaultValue": 35,
        "minimum": "0",
        "minimumValue": 0,
        "maximum": "100",
        "maximumValue": 100
    }
]
```

The initial value is clamped to the configured range. When the slider changes, DynamicUI emits
the component with its numeric `state` updated. `Slider` renders no view on tvOS.

## Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `title` | String | Accessibility label for the slider. |
| `identifier` | String | Key used for updates and conditional expressions. |
| `defaultValue` | Number | Initial value. Defaults to `minimumValue`. |
| `minimum` | String | Visible minimum-value label. |
| `minimumValue` | Number | Lower bound. Defaults to `0`. |
| `maximum` | String | Visible maximum-value label. |
| `maximumValue` | Number | Upper bound. Defaults to `1`. |
| `modifiers` | Object | Visual and behavioral modifiers. |
