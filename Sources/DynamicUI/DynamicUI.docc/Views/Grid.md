# Grid Example

```json
[
    {
        "type": "Grid",
        "parameters": {
            "horizontalSpacing": 12,
            "verticalSpacing": 8
        },
        "children": [
            {
                "type": "GridRow",
                "children": [
                    { "type": "Text", "title": "Name" },
                    { "type": "Text", "title": "Value" }
                ]
            }
        ]
    }
]
```

Grid requires iOS 16, macOS 13, tvOS 16, or watchOS 9 and falls back to VStack on older systems.

| Parameter | Type | Description |
| --- | --- | --- |
| `parameters.horizontalSpacing` | Number | Optional spacing between columns. |
| `parameters.verticalSpacing` | Number | Optional spacing between rows. |
| `children` | Array | GridRow components. |
| `modifiers` | Object | Visual and behavioral modifiers. |
