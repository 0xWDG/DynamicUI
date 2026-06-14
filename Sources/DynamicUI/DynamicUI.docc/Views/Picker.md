# Picker Example

This example demonstrates how to define a `Picker` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "Picker",
       "title": "Selection",
       "identifier": "selection",
       "defaultValue": 0,
       "children": [
            {
              "type": "Text",
              "title": "Item 1"
            },
            {
              "type": "Text",
              "title": "Item 2"
            },
            {
              "type": "Text",
              "title": "Item 3"
            }
       ]
    }
]
```

### Parameters

| Parameter | Type        | Description                       |
| --------- | ----------- | --------------------------------- |
The picker selects children by their zero-based position. `defaultValue` is clamped to the
available positions. When the selection changes, DynamicUI emits the picker with its numeric
`state` updated.

| `title` | String | Label for the picker. |
| `identifier` | String | Key used for updates and conditional expressions. |
| `defaultValue` | Number | Initial zero-based child position. Defaults to `0`. |
| `children` | Array | Options displayed by the picker. |
| `modifiers` | Object | Visual and behavioral modifiers. |
