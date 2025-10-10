# Gauge Example

This example demonstrates how to define a `Gauge` using DynamicUI's JSON schema.  

```json
[
    {
        "type": "Gauge",
        "title": "Gauge",
        "defaultValue": 0.5
    }
]
```

### Parameters

| Parameter | Type        | Description                       |
| --------- | ----------- | --------------------------------- |
| title     | String      | The title of the gauge.          |
| defaultValue | Number    | The default value of the gauge.  |
| modifiers | Object      | The visual modifiers for the gauge. |