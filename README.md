# DynamicUI

Convert your JSON to a SwiftUI View.

## Requirements

- Swift 5.9+ (Xcode 15+)
- iOS 15+, macOS 12+

## Installation

Install using Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/0xWDG/DynamicUI.git", .branch("main")),
],
targets: [
    .target(name: "MyTarget", dependencies: [
        .product(name: "DynamicUI", package: "DynamicUI"),
    ]),
]
```

And import it:
```swift
import DynamicUI
```

## Usage

```swift
import DynamicUI

struct ContentView: View {
    let json = """
    [
        {
            "type": "Text",
            "text": "Wait, am i generating views from JSON?"
        }
    ]
    """.data(using: .utf8)

    var body: some View {
        DynamicUI(
            json: json
        )
    }
}
```

### Supported View Types:
- [x] Text(...)
- [x] Image(systemName: ...)
- [ ] Button
- [x] VStack { ... }
- [x] HStack { ... }
- [ ] ZStack
- [ ] Spacer
- [ ] Divider
- [ ] List
- [ ] ScrollView
- [ ] NavigationView
- [ ] TabView
- [ ] LazyVStack
- [ ] LazyHStack
- [ ] LazyVGrid
- [ ] LazyHGrid
- [ ] ForEach
- [ ] Group
- [ ] Section
- [ ] Form
- [ ] NavigationLink
- [ ] Alert
- [ ] ActionSheet
- [ ] Sheet
- [ ] FullScreenCover
- [ ] TabItem
- [ ] Picker

## Images

<img width="835" alt="image" src="https://github.com/0xWDG/DynamicUI/assets/1290461/02e2d735-5496-4b68-a428-9e03815bf4d6">

## Contact

We can get in touch via [Twitter/X](https://twitter.com/0xWDG), [Discord](https://discordapp.com/users/918438083861573692), [Mastodon](https://iosdev.space/@0xWDG), [Threads](https://threads.net/@0xwdg), [Bluesky](https://bsky.app/profile/0xwdg.bsky.social).

Alternatively you can visit my [Website](https://wesleydegroot.nl).
