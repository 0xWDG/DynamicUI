# List Example

This example demonstrates how to define a `List` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "List",
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
| children  | Array       | The child elements of the List.   |
| modifiers | Object      | The visual modifiers for the List. |
