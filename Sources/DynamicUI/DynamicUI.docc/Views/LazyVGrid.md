# LazyVGrid Example

```json
[
    {
        "type": "LazyVGrid",
        "parameters": {
            "columns": 2,
            "minimum": 80,
            "maximum": 240,
            "spacing": 12
        },
        "children": [
            { "type": "Text", "title": "One" },
            { "type": "Text", "title": "Two" }
        ]
    }
]
```

All columns use flexible sizing.

| Parameter | Type | Description |
| --- | --- | --- |
| `parameters.columns` | Integer | Flexible column count from `1` through `50`. |
| `parameters.minimum`, `parameters.maximum` | Number | Flexible item size bounds. |
| `parameters.spacing` | Number | Grid and item spacing. |
| `children` | Array | Lazily created grid items. |
| `modifiers` | Object | Visual and behavioral modifiers. |
