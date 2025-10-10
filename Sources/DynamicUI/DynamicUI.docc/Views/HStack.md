# HStack Example

This example demonstrates how to define a `HStack` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "HStack",
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
| children  | Array       | The child elements of the HStack. |
| modifiers | Object      | The visual modifiers for the HStack. |