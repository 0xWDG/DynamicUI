# NavigationLink Example

```json
[
    {
        "type": "NavigationLink",
        "title": "Settings",
        "url": "gear",
        "children": [
            { "type": "Text", "title": "Settings content" }
        ]
    }
]
```

| Parameter | Type | Description |
| --- | --- | --- |
| `title` | String | Accessible link label. |
| `url` | String | Optional SF Symbol shown beside the title. |
| `children` | Array | Destination content. |
| `modifiers` | Object | Visual and behavioral modifiers. |
