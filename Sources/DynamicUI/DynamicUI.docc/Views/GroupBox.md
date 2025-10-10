# GroupBox Example

This example demonstrates how to define a `GroupBox` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "GroupBox"
       "children": [
              {
                "type": "Text",
                "title": "Content goes here",
              }
         ]
       }
    }
]
```

### Parameters

| Parameter | Type        | Description                       |
| --------- | ----------- | --------------------------------- |
| title     | String      | The title of the groupbox.       |
| children  | Array       | The child elements of the groupbox. |
| modifiers | Object      | The visual modifiers for the groupbox. |