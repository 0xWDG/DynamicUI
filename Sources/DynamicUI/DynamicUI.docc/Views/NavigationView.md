# NavigationView Example

This example demonstrates how to define a `NavigationView` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "NavigationView",
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
| children  | Array       | The child elements of the NavigationView. |
| modifiers | Object      | The visual modifiers for the NavigationView. |