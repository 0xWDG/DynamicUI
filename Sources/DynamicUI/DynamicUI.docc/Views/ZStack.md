# ZStack Example

This example demonstrates how to define a `ZStack` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "ZStack",
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
| children  | Array       | The child elements of the ZStack. |
| modifiers | Object      | The visual modifiers for the ZStack. |