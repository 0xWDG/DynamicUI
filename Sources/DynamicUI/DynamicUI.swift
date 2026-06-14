//
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
    /// DynamicUIComponent state change handler
    public typealias Callback = (DynamicUIComponent) -> Void

    /// JSON data to generate the interface from
    private let json: Data

    /// Callback for interactions with the DynamicUIComponents
    @Binding
    var component: DynamicUIComponent?

    /// This state is used to store the error message
    @Binding
    private var error: Error?

    /// Internal error state
    @State
    private var internalError: Error?

    /// This state is used to store the layout
    @State
    private var layout: [DynamicUIComponent]?

    /// Current component values keyed by identifier.
    @State
    private var values: [String: AnyCodable] = [:]

    /// Initialize DynamicUI
    ///
    /// - Parameter json: JSON Data
    /// - Parameter component: Binding for the dynamic UI element
    /// - Parameter error: Error message
    public init(json: Data, component: Binding<DynamicUIComponent?>, error: Binding<Error?>? = nil) {
        self.json = json
        self._component = component
        self._error = error ?? .constant(nil)
    }

    /// Initialize DynamicUI
    ///
    /// - Parameter json: JSON String
    /// - Parameter component: Binding for the dynamic UI element
    /// - Parameter error: Error message
    public init(json: String, component: Binding<DynamicUIComponent?>, error: Binding<Error?>? = nil) {
        self.json = Data(json.utf8)
        self._component = component
        self._error = error ?? .constant(nil)
    }

    /// Initialize DynamicUI
    ///
    /// - Parameter json: JSON Data
    /// - Parameter callback: Callback handler for updates
    /// - Parameter error: Error message
    public init(json: Data, callback: @escaping Callback, error: Binding<Error?>? = nil) {
        self.json = json
        self._component = Binding<DynamicUIComponent?>(
            get: { nil },
            set: { value in
                if let value {
                    callback(value)
                }
            }
        )
        self._error = error ?? .constant(nil)
    }

    /// Initialize DynamicUI
    ///
    /// - Parameter json: JSON String
    /// - Parameter callback: Callback handler for updates
    /// - Parameter error: Error message
    public init(json: String, callback: @escaping Callback, error: Binding<Error?>? = nil) {
        self.json = Data(json.utf8)
        self._component = Binding<DynamicUIComponent?>(
            get: { nil },
            set: { value in
                if let value {
                    callback(value)
                }
            }
        )
        self._error = error ?? .constant(nil)
    }

    /// Initialize the DynamicUI
    public var body: some View {
        VStack {
            if let layout = layout {
                buildView(for: layout)
                    .id(json)
                    .environment(\.internalDynamicUIEnvironment, self)
            } else if let error = internalError {
                Image(systemName: "exclamationmark.arrow.triangle.2.circlepath")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding(.vertical)

                Text("Failed to generate interface...")
                    .font(.title)
                    .padding(.vertical)

#if DEBUG
                Text(error.localizedDescription)
#endif
            } else {
                ProgressView()
                    .frame(width: 150, height: 150)
#if !os(tvOS) && !os(watchOS)
                    .controlSize(.large)
#endif
                    .padding()

                Text("Generating interface...")
            }
        }
        .task(id: json) {
            decodeJSON()
        }
    }

    /// Decode the JSON data
    private func decodeJSON() {
        internalError = nil
        error = nil

        do {
            layout = try JSONDecoder().decode(
                [DynamicUIComponent].self,
                from: json
            )
            values = initialValues(in: layout ?? [])
        } catch {
            layout = nil
            internalError = error
            self.error = error
#if DEBUG
            print(error)
#endif
        }
    }

    /// Build a SwiftUI View based on the components
    /// - Parameter components: [UIComponent]
    /// - Returns: A SwiftUI View
    func buildView(for components: [DynamicUIComponent]) -> some View {
        // swiftlint:disable:previous cyclomatic_complexity function_body_length
        ForEach(components.indices, id: \.self) { index in
            let component = components[index].resolvingStrings(values: values)

            switch component.type {
            case "Button":
                DynamicButton(component)

            case "VStack":
                DynamicVStack(component)

            case "HStack":
                DynamicHStack(component)

            case "ZStack":
                DynamicZStack(component)

            case "List":
                DynamicList(component)

            case "ScrollView":
                DynamicScrollView(component)

            case "NavigationView":
                DynamicNavigationView(component)

            case "Form":
                DynamicForm(component)

            case "Text":
                DynamicText(component)

            case "Image":
                DynamicImage(component)

            case "Divider":
                DynamicDivider(component)

            case "Spacer":
                DynamicSpacer(component)

            case "Section":
                DynamicSection(component)

            case "Label":
                DynamicLabel(component)

            case "TextField":
                DynamicTextField(component)

            case "SecureField":
                DynamicSecureField(component)

            case "TextEditor":
                DynamicTextEditor(component)

            case "Toggle":
                DynamicToggle(component)

            case "Gauge":
                DynamicGauge(component)

            case "ProgressView":
                DynamicProgressView(component)

            case "Slider":
                DynamicSlider(component)

            case "GroupBox":
                DynamicGroupBox(component)

            case "Group":
                DynamicGroup(component)

            case "DisclosureGroup":
                DynamicDisclosureGroup(component)

            case "HSplitView":
                DynamicHSplitView(component)

            case "VSplitView":
                DynamicVSplitView(component)

            case "Picker":
                DynamicPicker(component)

            // NavigationSplitView
            // TabView

            default:
                EmptyView()
            }
        }
    }

    /// Store a component update and forward it to the public binding or callback.
    func sendUpdate(_ updatedComponent: DynamicUIComponent) {
        if let identifier = updatedComponent.identifier,
           let state = updatedComponent.state {
            values[identifier] = state
        }

        component = updatedComponent
    }

    private func initialValues(in components: [DynamicUIComponent]) -> [String: AnyCodable] {
        components.reduce(into: [:]) { values, component in
            if let identifier = component.identifier {
                values[identifier] = component.state ?? component.defaultValue ?? .bool(false)
            }

            values.merge(initialValues(in: component.children ?? [])) { _, newValue in newValue }
        }
    }
}

private struct InternalDynamicUIKey: EnvironmentKey {
    static let defaultValue = DynamicUI(json: Data(), component: .constant(nil))
}

extension EnvironmentValues {
    var internalDynamicUIEnvironment: DynamicUI {
        get { self[InternalDynamicUIKey.self] }
        set { self[InternalDynamicUIKey.self] = newValue }
    }
}
