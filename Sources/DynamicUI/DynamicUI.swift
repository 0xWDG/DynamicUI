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
    private var json: Data?

    /// Legacy callback support
    private var legacyCallback: Callback?

    /// Callback for interactions with the DynamicUIComponents
    @Binding
    var component: DynamicUIComponent?

    /// This state is used to store the error message
    @Binding
    private var error: Error?

    /// This state is used to store the layout
    @State
    private var layout: [DynamicUIComponent]?

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
        self.json = json.data(using: .utf8)
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
        self.legacyCallback = callback
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
        self.json = json.data(using: .utf8)
        self.legacyCallback = callback
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
            } else if let error = error {
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
        .onAppear {
            decodeJSON()
        }
    }

    /// Decode the JSON data
    private func decodeJSON() {
        do {
            if let json = json {
                self.layout = try JSONDecoder().decode(
                    [DynamicUIComponent].self,
                    from: json
                )
            }
            self.error = nil
        } catch {
            self.error = error
        }
    }

    /// Build a SwiftUI View based on the components
    /// - Parameter components: [UIComponent]
    /// - Returns: A SwiftUI View
    func buildView(for components: [DynamicUIComponent]) -> some View {
        // swiftlint:disable:previous cyclomatic_complexity function_body_length
        return ForEach(components, id: \.self) { component in
            switch component.type {
            case "Button":
                DynamicButton(component)
                    .environment(\.internalDynamicUIEnvironment, self)

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
    static let defaultValue: DynamicUI = defaultValue
}

extension EnvironmentValues {
    var internalDynamicUIEnvironment: DynamicUI {
        get { self[InternalDynamicUIKey.self] }
        set { self[InternalDynamicUIKey.self] = newValue }
    }
}
