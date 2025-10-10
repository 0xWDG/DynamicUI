# DisclosureGroup Example

This example demonstrates how to define a `DisclosureGroup` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "DisclosureGroup",
       "title": "Title",
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
| title     | String      | The title of the disclosure group.|
| children  | Array       | The child elements of the disclosure group. |
| modifiers | Object      | The visual modifiers for the disclosure group. |