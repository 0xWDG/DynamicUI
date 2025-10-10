# Group Example

This example demonstrates how to define a `Group` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "Group",
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
| title     | String      | The title of the group.          |
| children  | Array       | The child elements of the group. |
| modifiers | Object      | The visual modifiers for the group. |