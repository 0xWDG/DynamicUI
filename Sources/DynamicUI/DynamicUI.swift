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
    
    @State private var tfState1 = ""
    @State private var boolState = false
    @State private var gauge = 0.5

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

            case "ZStack":
                ZStack {
                    if let children = component.children {
                        AnyView(self.buildView(for: children))
                    }
                }

            case "List":
                List {
                    if let children = component.children {
                        AnyView(self.buildView(for: children))
                    }
                }

            case "ScrollView":
                ScrollView {
                    if let children = component.children {
                        AnyView(self.buildView(for: children))
                    }
                }

            case "NavigationView":
                NavigationView {
                    if let children = component.children {
                        AnyView(self.buildView(for: children))
                    }
                }

            case "Form":
                Form {
                    if let children = component.children {
                        AnyView(self.buildView(for: children))
                    }
                }

            case "Text":
                Text(component.text ?? "")

            case "Image":
                Image(systemName: component.imageURL ?? "")

            case "Divider":
                Divider()

            case "Spacer":
                Spacer()

            case "Label":
                Label("\(component.title)", systemImage: component.imageURL ?? "")

            case "TextField":
                TextField(
                    "\(component.title)",
                    text: $tfState1
                )

            case "SecureField":
                SecureField(
                    "\(component.title)",
                    text: $tfState1
                )

            case "TextEditor":
                TextEditor(text: $tfState1)

            case "Toggle":
                DynamicToggle(component)

            case "Gauge":
                if #available(macOS 13.0, *) {
                    Gauge(value: gauge) {
                        Text("\(component.title)")
                    }
                } else {
                    EmptyView()
                }

            case "ProgressView":
                ProgressView("\(component.title)", value: 50, total: 100)

            case "Slider":
                Slider(value: $gauge) {
                    Text("\(component.title)")
                } minimumValueLabel: {
                    Text("")
                } maximumValueLabel: {
                    Text("")
                }

//            // Static method 'buildExpression' requires that 'VStack<AnyView?>' conform to 'TableRowContent'
//            case "GroupBox":
//                GroupBox {
//                    if let children = component.children {
//                        AnyView(self.buildView(for: children))
//                    }
//                } label: {
//                    component.title ?? ""
//                }
//            // Static method 'buildExpression' requires that 'VStack<AnyView?>' conform to 'TableRowContent'
//            case "DisclosureGroup":
//                DisclosureGroup {
//                    if let children = component.children {
//                        AnyView(self.buildView(for: children))
//                    }
//                } label: {
//                    component.title ?? ""
//                }

            case "HSplitView":
                HSplitView {
                    if let children = component.children {
                        AnyView(self.buildView(for: children))
                    }
                }

            case "VSplitView":
                VSplitView {
                    if let children = component.children {
                        AnyView(self.buildView(for: children))
                    }
                }

//            // Static method 'buildExpression' requires that 'VStack<AnyView?>' conform to 'TableRowContent'
//            case "Picker":
//                Picker(component.title ?? "", selection: $bindingPicker) {
//                    if let children = component.children {
//                        AnyView(self.buildView(for: children))
//                    }
//                }

            // NavigationSplitView
            // TabView

            default:
                EmptyView()
            }
        }
    }
}
