# TabView Example

This example demonstrates how to define a `TabView` using DynamicUI's JSON schema.
Each child becomes a tab. The child's `title` is used as its tab label and its optional
`url` is used as the label's SF Symbol.

```json
[
    {
       "type": "TabView",
       "children": [
            {
              "type": "Text",
              "title": "Home",
              "url": "house"
            },
            {
              "type": "Text",
              "title": "Settings",
              "url": "gear"
            }
       ]
    }
]
```

### Parameters

| Parameter | Type   | Description                                |
| --------- | ------ | ------------------------------------------ |
| children  | Array  | The child elements displayed as tabs.      |
| modifiers | Object | The visual modifiers for the TabView.       |
