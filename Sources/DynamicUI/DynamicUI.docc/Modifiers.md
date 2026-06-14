# Supported Modifiers

Apply modifiers by adding a `modifiers` object to any component. Unsupported keys and values are
ignored.

```json
{
    "type": "Text",
    "title": "Styled text",
    "modifiers": {
        "foregroundColor": "purple",
        "padding": 12,
        "opacity": 0.8
    }
}
```

## Reference

| Modifier | Accepted value | Description |
| --- | --- | --- |
| `color`, `foregroundStyle`, `foregroundColor` | Color string | Sets the foreground style. |
| `background`, `backgroundColor`, `backgroundStyle` | Color string | Sets the background color. |
| `fontWeight` | Font weight string | Sets the font weight. |
| `font` | Text style string or font object | Sets a semantic or fixed-size font. |
| `bold` | Boolean | Applies bold styling. Defaults to `true` when the value is not Boolean. |
| `italic` | Boolean | Applies italic styling. Defaults to `true` when the value is not Boolean. |
| `monospaced` | Boolean | Applies a monospaced font. Defaults to `true` when the value is not Boolean. |
| `frame` | Frame object | Sets fixed or flexible frame dimensions and alignment. |
| `opacity` | Number | Sets opacity. |
| `disabled` | Boolean | Disables interaction. The component-level `disabled` field also sets this modifier. |
| `padding` | Boolean, number, or edge object | Adds default, uniform, or per-edge padding. |
| `margin` | Edge object | Alias for per-edge padding. |
| `shadow` | Shadow object | Adds a shadow. |

## Colors

Supported color names are `red`, `orange`, `yellow`, `green`, `mint`, `teal`, `cyan`, `blue`,
`indigo`, `purple`, `pink`, `brown`, `white`, `gray`, `black`, `clear`, `primary`, and
`secondary`. Color names are case-insensitive. An unrecognized color falls back to `primary`.

```json
{
    "foregroundColor": "purple",
    "backgroundColor": "yellow"
}
```

## Fonts

Supported font weights are `ultraLight`, `thin`, `light`, `regular`, `medium`, `semibold`,
`bold`, `heavy`, and `black`.

```json
{
    "fontWeight": "bold"
}
```

The `font` modifier accepts a semantic text style:

```json
{
    "font": "headline"
}
```

Supported text style names include `largeTitle`, `title`, `title2`, `title3`, `headline`,
`subheadline`, `body`, `callout`, `footnote`, `caption`, and `caption2`.

For a fixed-size system font, provide a `size` and optional `weight`:

```json
{
    "font": {
        "size": 16,
        "weight": "bold"
    }
}
```

## Frames

```json
{
    "frame": {
        "minWidth": 100,
        "maxWidth": 300,
        "height": 50,
        "alignment": "leading"
    }
}
```

Supported dimension keys are `width`, `height`, `minWidth`, `idealWidth`, `maxWidth`,
`minHeight`, `idealHeight`, and `maxHeight`. Supported alignments are `leading`, `center`, and
`trailing`; other values use `center`.

When `width` or `height` is present, DynamicUI applies a fixed-size frame and ignores the flexible
dimension keys.

## Spacing

```json
{
    "padding": true
}
```

```json
{
    "padding": 10
}
```

```json
{
    "padding": {
        "top": 10,
        "bottom": 5,
        "leading": 15,
        "trailing": 20
    }
}
```

Omitted edge values default to zero. `margin` accepts the same edge object and currently behaves
the same as `padding`.

## Shadows

The `radius` field is required. `color`, `x`, and `y` are optional and default to `black`, `0`,
and `0`.

```json
{
    "shadow": {
        "color": "black",
        "radius": 4,
        "x": 0,
        "y": 2
    }
}
```
