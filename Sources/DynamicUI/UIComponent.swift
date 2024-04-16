import SwiftUI

struct UIComponent: Codable, Hashable {
    let type: String
    let text: String?
    let title: String?
    let defaultValue: AnyCodable?
    let styling: [[String: AnyCodable]]?
    let imageURL: String?
    let children: [UIComponent]?
}
