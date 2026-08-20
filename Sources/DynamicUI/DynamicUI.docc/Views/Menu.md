# Menu Example

```json
[
    {
        "type": "Menu",
        "title": "Actions",
        "url": "ellipsis.circle",
        "children": [
            { "type": "Button", "title": "Duplicate", "identifier": "duplicate" },
            { "type": "Button", "title": "Delete", "identifier": "delete" }
        ]
    }
]
```

The `url` is an optional SF Symbol for the menu label. On platforms without native Menu support,
the label and children render as an accessible vertical group.

| Parameter | Type | Description |
| --- | --- | --- |
| `title` | String | Accessible menu label. |
| `url` | String | Optional SF Symbol for the label. |
| `children` | Array | Menu actions, normally Button components. |
| `modifiers` | Object | Visual and behavioral modifiers. |
