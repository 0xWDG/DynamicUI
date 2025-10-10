# Picker Example

This example demonstrates how to define a `Picker` using DynamicUI's JSON schema.  

```json
[
    {
       "type": "Picker",
       "children": [
              {
                "id": "item1",
                "type": "Text",
                "title": "Item 1"
              },
              {
                "id": "item2",
                "type": "Text",
                "title": "Item 2",
                "disabled": true
              },
              {
                "id": "item3",
                "type": "Text",
                "title": "Item 3"
              }
         ]
       }
    }
]
```

### Parameters

| Parameter | Type        | Description                       |
| --------- | ----------- | --------------------------------- |
| children  | Array       | The child elements of the Picker. |
| modifiers | Object      | The visual modifiers for the Picker. |