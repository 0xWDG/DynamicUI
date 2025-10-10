# HSplitView Example

This example demonstrates how to define a `HSplitView` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "HSplitView",
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
| children  | Array       | The child elements of the HSplitView. |
| modifiers | Object      | The visual modifiers for the HSplitView. |