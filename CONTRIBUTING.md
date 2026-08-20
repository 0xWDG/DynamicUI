# Contributing to DynamicUI

Thanks for helping make JSON-driven SwiftUI useful, reliable, and accessible across Apple
platforms.

## Before you start

- Search existing issues and pull requests before opening a new one.
- For a focused bug fix or documentation improvement, feel free to open a pull request directly.
- For a new component, schema change, or public API, open a feature request first so the design can
  be discussed before implementation.
- Please keep changes focused. Unrelated refactors make reviews harder.

## Development setup

Requirements:

- Xcode 15 or newer
- Swift 5.9 or newer

Clone the repository and run the test suite:

```sh
git clone https://github.com/0xWDG/DynamicUI.git
cd DynamicUI
swift test
./build.command
```

The `Playground` Xcode project contains examples for supported Apple platforms. Use it to verify
visual and interactive changes in addition to unit tests.

## Adding or changing a component

When changing rendered UI:

1. Add or update the component implementation and its schema documentation.
2. Preserve native SwiftUI semantics and Dynamic Type behavior.
3. Add explicit accessibility metadata where the visible content is not sufficient.
4. Verify VoiceOver labels, values, hints, and traversal order.
5. Ensure interactive elements remain usable with Voice Control, Switch Control, and keyboard
   input where the platform supports them.
6. Add unit tests and a self-contained preview or playground example.
7. Confirm every supported platform still compiles.

New JSON fields must be optional or introduced through a new schema version. Existing top-level
array payloads must remain compatible unless a breaking release explicitly says otherwise.

## Pull requests

- Explain the user-facing problem and the chosen approach.
- Link the relevant issue when one exists.
- Include screenshots or a short recording for visible changes.
- Run `swift test` before submitting.
- Update README and DocC documentation for public behavior.
- Do not include generated build output or personal Xcode settings.

By participating, you agree to follow the [Code of Conduct](CODE_OF_CONDUCT.md).
