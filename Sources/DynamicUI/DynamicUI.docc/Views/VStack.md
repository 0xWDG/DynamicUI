# VStack Example

This example demonstrates how to define a `VStack` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "VStack",
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
| children  | Array       | The child elements of the VStack. |
| modifiers | Object      | The visual modifiers for the VStack. |