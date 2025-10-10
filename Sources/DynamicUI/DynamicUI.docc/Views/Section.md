# Section Example

This example demonstrates how to define a `Section` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "Section",
       "title": "Section Title",
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
| title     | String      | The title of the Section.        |
| children  | Array       | The child elements of the Section. |
| modifiers | Object      | The visual modifiers for the Section. |