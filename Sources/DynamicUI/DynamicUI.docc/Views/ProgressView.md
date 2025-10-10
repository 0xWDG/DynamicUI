# ProgressView Example

This example demonstrates how to define a `ProgressView` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "ProgressView",
       "title": "Title",
       "defaultValue": 0.5,
       "maximumValue": 1.0,
       "modifiers": {
           "foregroundColor": "purple"
       }
    }
]
```

### Parameters

| Parameter | Type        | Description                       |
| --------- | ----------- | --------------------------------- |
| title     | String      | The title of the ProgressView.         |
| defaultValue | Double    | The default value of the progress. |
| maximumValue | Double    | The maximum value of the progress. |
| modifiers | Object      | The visual modifiers for the ProgressView. |