# DynamicUI JSON Example

This example demonstrates how to define a form using DynamicUI's JSON schema.  
The form includes a section with three toggles, each illustrating different configuration options.

```json
[
    {
        "type": "Form",
        "children": [
            {
                "type": "Section",
                "title": "Form example",
                "children": [
                    {
                        "type": "Toggle",
                        "title": "Toggle"
                    },
                    {
                        "type": "Toggle",
                        "title": "Toggle",
                        "defaultValue": true
                    },
                    {
                        "type": "Toggle",
                        "title": "Toggle",
                        "defaultValue": true,
                        "disabled": true
                    }
                ]
            }
        ]
    }
]
```

## Explanation

- **Form**: The root container for UI elements.
- **Section**: Logical grouping within the form, titled "Form example".
- **Toggle**: Each toggle switch represents a boolean option.
    - The first toggle has default settings.
    - The second toggle is turned on by default (`defaultValue: true`).
    - The third toggle is on by default and disabled (`disabled: true`).

Use this pattern to build custom forms with sections and controls using DynamicUI's JSON schema.
