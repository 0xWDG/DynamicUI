# GridRow Example

```json
[
    {
        "type": "GridRow",
        "children": [
            { "type": "Text", "title": "Name" },
            { "type": "Text", "title": "Value" }
        ]
    }
]
```

GridRow requires iOS 16, macOS 13, tvOS 16, or watchOS 9 and falls back to HStack on older systems.

| Parameter | Type | Description |
| --- | --- | --- |
| `children` | Array | Cells in the row. |
| `modifiers` | Object | Visual and behavioral modifiers. |
