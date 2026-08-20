# Stepper Example

```json
[
    {
        "type": "Stepper",
        "title": "Guests",
        "identifier": "guests",
        "defaultValue": 2,
        "minimumValue": 1,
        "maximumValue": 10,
        "parameters": {
            "step": 1
        }
    }
]
```

Changes emit the selected number in `state`. Stepper is unavailable on tvOS and requires watchOS 9.

| Parameter | Type | Description |
| --- | --- | --- |
| `title` | String | Accessible label displayed with the current value. |
| `identifier` | String | Key used for updates and conditional expressions. |
| `defaultValue` | Number | Initial value, clamped to the configured range. |
| `minimumValue`, `maximumValue` | Number | Inclusive range. Defaults to `0...100`. |
| `parameters.step` | Number | Increment size. Defaults to `1`. |
| `modifiers` | Object | Visual and behavioral modifiers. |
