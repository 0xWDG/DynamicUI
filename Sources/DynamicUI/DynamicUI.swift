//
//  DynamicUI.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 16/04/2024.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import SwiftUI

/// DynamicUI
///
/// DynamicUI is a SwiftUI View that can be used to display an interface based on JSON.
public struct DynamicUI: View {
    /// JSON data
    public var json: Data?
    
    /// Initialize DynamicUI
    /// - Parameter json: JSON data
    public init(json: Data? = nil) {
        self.json = json
    }

    /// Generated body for SwiftUI
    public var body: some View {
        AnyView(
            InternalDynamicUI(json: json)
        )
    }
}

/// InternalDynamicUI (internal)
/// InternalDynamicUI is a SwiftUI View that can be used to display an interface based on JSON.
/// - Parameter json: JSON Data
/// - Returns: A SwiftUI View
struct InternalDynamicUI: View {
    /// JSON Data
    public var json: Data?

    @State
    /// This state is used to store the layout
    private var layout: [UIComponent]?

    @State
    /// This state is used to store the error message
    private var error: String?

    /// Initialize the InternalDynamicUI
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
            decodeJSON()
        }
    }

    /// Decode the JSON data
    private func decodeJSON() {
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

    /// Build a SwiftUI View based on the components
    /// - Parameter components: [UIComponent]
    /// - Returns: A SwiftUI View
    func buildView(for components: [UIComponent]) -> some View {
        // swiftlint:disable:previous cyclomatic_complexity function_body_length
        return ForEach(components, id: \.self) { component in
            switch component.type {
            case "VStack":
                DynamicVStack(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "HStack":
                DynamicHStack(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "ZStack":
                DynamicZStack(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "List":
                DynamicList(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "ScrollView":
                DynamicScrollView(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "NavigationView":
                DynamicNavigationView(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "Form":
                DynamicForm(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "Text":
                DynamicText(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "Image":
                DynamicImage(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "Divider":
                Divider()
                    .environment(\.internalDynamicUIEnvironment, self)

            case "Spacer":
                Spacer()
                    .environment(\.internalDynamicUIEnvironment, self)

            case "Label":
                DynamicLabel(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "TextField":
                DynamicTextField(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "SecureField":
                DynamicSecureField(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "TextEditor":
                DynamicTextEditor(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "Toggle":
                DynamicToggle(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "Gauge":
                DynamicGauge(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "ProgressView":
                DynamicProgressView(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "Slider":
                DynamicSlider(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "GroupBox":
                DynamicGroupBox(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "DisclosureGroup":
                DynamicDisclosureGroup(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "HSplitView":
                DynamicHSplitView(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "VSplitView":
                DynamicVSplitView(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            case "Picker":
                DynamicPicker(component)
                    .environment(\.internalDynamicUIEnvironment, self)

            // NavigationSplitView
            // TabView

            default:
                EmptyView()
            }
        }
    }
}

private struct InternalDynamicUIKey: EnvironmentKey {
    static let defaultValue: InternalDynamicUI = defaultValue
}

extension EnvironmentValues {
    var internalDynamicUIEnvironment: InternalDynamicUI {
        get { self[InternalDynamicUIKey.self] }
        set { self[InternalDynamicUIKey.self] = newValue }
    }
}
