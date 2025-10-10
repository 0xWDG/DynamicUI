# ScrollView Example

This example demonstrates how to define a `ScrollView` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "ScrollView",
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
| children  | Array       | The child elements of the ScrollView. |
| modifiers | Object      | The visual modifiers for the ScrollView. |