# LazyVStack Example

```json
[
    {
        "type": "ScrollView",
        "children": [
            {
                "type": "LazyVStack",
                "parameters": { "alignment": "leading", "spacing": 12 },
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
| `parameters.alignment` | String | `leading`, `center` (default), or `trailing`. |
| `parameters.spacing` | Number | Optional spacing between children. |
| `children` | Array | Lazily created vertical content. |
| `modifiers` | Object | Visual and behavioral modifiers. |
