# LazyHStack Example

```json
[
    {
        "type": "ScrollView",
        "children": [
            {
                "type": "LazyHStack",
                "parameters": { "alignment": "top", "spacing": 12 },
                "children": [
                    { "type": "Text", "title": "First" },
                    { "type": "Text", "title": "Second" }
                ]
            }
        ]
    }
]
```

| Parameter | Type | Description |
| --- | --- | --- |
| `parameters.alignment` | String | `top`, `center` (default), or `bottom`. |
| `parameters.spacing` | Number | Optional spacing between children. |
| `children` | Array | Lazily created horizontal content. |
| `modifiers` | Object | Visual and behavioral modifiers. |
