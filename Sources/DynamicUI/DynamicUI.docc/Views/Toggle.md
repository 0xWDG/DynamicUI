# Toggle Example

This example demonstrates how to define a `Toggle` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "Toggle",
       "title": "Enable Feature",
       "defaultValue": true
    }
]
```

### Parameters

| Parameter | Type        | Description                       |
| --------- | ----------- | --------------------------------- |
| title     | String      | The title of the Toggle.          |
| defaultValue      | Boolean     | The state of the Toggle (true for on, false for off). |
| modifiers | Object      | The visual modifiers for the Toggle. |