//
//  DynamicInvalidTest.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//

import SwiftUI

#if DEBUG
#Preview("DynamicInvalidTest") {
    DynamicUIPreviewFixtures.view("""
        {
        "type": "VStack",
        "children": [
            {
                "type": "AsyncImage",
                "title": "Wesley's avatar",
                "url": "https://wesleydegroot.nl/assets/avatar/avatar.webp"
            },
            { "type": "Divider" },
            { "type": "D", "comment": "This should NOT FAIL" },
            { "test": true, "comment": "This should be ignored and not fail" },
            {
                "type": "AsyncImage",
                "title": "Remote image preview",
                "url": "invalid-preview-url"
            }
        ]
        }
        """)
}
#endif
