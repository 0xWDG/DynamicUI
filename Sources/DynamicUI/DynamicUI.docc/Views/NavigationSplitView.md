# NavigationSplitView Example

This example demonstrates how to define a `NavigationSplitView` using DynamicUI's JSON schema.
The first child is displayed in the sidebar and the remaining children are displayed in the
detail column. On platforms that do not support `NavigationSplitView`, it falls back to
`NavigationView`.

```json
[
    {
       "type": "NavigationSplitView",
       "children": [
            {
              "type": "Text",
              "title": "Sidebar"
            },
            {
              "type": "Text",
              "title": "Detail"
            }
       ]
    }
]
```

### Parameters

| Parameter | Type   | Description                                          |
| --------- | ------ | ---------------------------------------------------- |
| children  | Array  | Sidebar child followed by detail children.           |
| modifiers | Object | The visual modifiers for the NavigationSplitView.    |
