struct UIComponent: Codable, Hashable {
    let type: String
    let text: String?
    let styling: [[String: String]]?
    let imageURL: String?
    let children: [UIComponent]?
}
