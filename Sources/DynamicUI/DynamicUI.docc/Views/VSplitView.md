# VSplitView Example

This example demonstrates how to define a `VSplitView` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "VSplitView",
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
| children  | Array       | The child elements of the VSplitView. |
| modifiers | Object      | The visual modifiers for the VSplitView. |