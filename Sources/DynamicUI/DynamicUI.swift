import SwiftUI

public func DynamicUI(json: Data?) -> some View {
    return AnyView(
        InternalDynamicUI(json: json)
    )
}

struct InternalDynamicUI: View {
    public var json: Data?
    @State private var layout: [UIComponent]?
    @State private var error: String?
    
    var body: some View {
        VStack {
            if let layout = layout {
                buildView(for: layout)
            } else if let error = error {
                Text("Failed to generate interface...")
                Text(error)
            } else {
                ProgressView()
                    .controlSize(.large)
                    .padding()

                Text("Generating interface...")
            }
        }
        .onAppear {
            generate()
        }
    }

    private func generate() {
        do {
            if let json = json {
                self.layout = try JSONDecoder().decode(
                    [UIComponent].self,
                    from: json
                )
            }
        } catch {
            self.error = "Error decoding JSON: \(error)"
        }
    }

    private func buildView(for components: [UIComponent]) -> some View {
        return ForEach(components, id: \.self) { component in
            switch component.type {
            case "VStack":
                VStack {
                    if let children = component.children {
                        AnyView(buildView(for: children))
                    }
                }

            case "HStack":
                HStack {
                    if let children = component.children {
                        AnyView(self.buildView(for: children))
                    }
                }

            case "Text":
                Text(component.text ?? "")

            case "Image":
                Image(systemName: component.imageURL ?? "")

            default:
                EmptyView()
            }
        }
    }
}
