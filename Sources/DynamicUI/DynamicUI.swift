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
import OSLog

/// DynamicUI
///
/// DynamicUI is a SwiftUI View that can be used to display an interface based on JSON.
public struct DynamicUI: View {
    private static let logger = Logger(
        subsystem: "nl.wesleydegroot.DynamicUI",
        category: "Rendering"
    )

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
        .onAppear {
            decodeJSON()
        }
        .dynamicUIOnChange(of: json) { _ in
            decodeJSON()
        }
    }

    /// Decode the JSON data
    private func decodeJSON() {
        internalError = nil
        error = nil

        do {
            let decodedLayout = try DynamicUILayoutDecoder.decode(from: json)
            layout = decodedLayout
            values = initialValues(in: decodedLayout)
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
        let visibleComponents = components.filter { $0.shouldRender(values: values) }
        return ForEach(visibleComponents.indices, id: \.self) { index in
            let component = visibleComponents[index].resolvingStrings(values: values)

            switch DynamicUIViewType(rawValue: component.type) {
            case .asyncImage:
                DynamicAsyncImage(component)

            case .button:
                DynamicButton(component)

            case .colorPicker:
                DynamicColorPicker(component)

            case .datePicker:
                DynamicDatePicker(component)

            case .vStack:
                DynamicVStack(component)

            case .hStack:
                DynamicHStack(component)

            case .zStack:
                DynamicZStack(component)

            case .list:
                DynamicList(component)

            case .scrollView:
                DynamicScrollView(component)

            case .navigationView:
                DynamicNavigationView(component)

            case .navigationStack:
                DynamicNavigationStack(component)

            case .navigationLink:
                DynamicNavigationLink(component)

            case .form:
                DynamicForm(component)

            case .text:
                DynamicText(component)

            case .image:
                DynamicImage(component)

            case .divider:
                DynamicDivider(component)

            case .spacer:
                DynamicSpacer(component)

            case .section:
                DynamicSection(component)

            case .label:
                DynamicLabel(component)

            case .textField:
                DynamicTextField(component)

            case .secureField:
                DynamicSecureField(component)

            case .textEditor:
                DynamicTextEditor(component)

            case .toggle:
                DynamicToggle(component)

            case .gauge:
                DynamicGauge(component)

            case .progressView:
                DynamicProgressView(component)

            case .slider:
                DynamicSlider(component)

            case .stepper:
                DynamicStepper(component)

            case .groupBox:
                DynamicGroupBox(component)

            case .group:
                DynamicGroup(component)

            case .disclosureGroup:
                DynamicDisclosureGroup(component)

            case .hSplitView:
                DynamicHSplitView(component)

            case .vSplitView:
                DynamicVSplitView(component)

            case .picker:
                DynamicPicker(component)

            case .navigationSplitView:
                DynamicNavigationSplitView(component)

            case .tabView:
                DynamicTabView(component)

            case .link:
                DynamicLink(component)

            case .menu:
                DynamicMenu(component)

            case .shareLink:
                DynamicShareLink(component)

            case .lazyVStack:
                DynamicLazyVStack(component)

            case .lazyHStack:
                DynamicLazyHStack(component)

            case .lazyVGrid:
                DynamicLazyVGrid(component)

            case .lazyHGrid:
                DynamicLazyHGrid(component)

            case .grid:
                DynamicGrid(component)

            case .gridRow:
                DynamicGridRow(component)

            case nil:
                unsupportedView(for: component.type)
            }
        }
    }

    private func unsupportedView(for type: String) -> EmptyView {
        Self.logger.error("Unsupported DynamicUI view type: \(type, privacy: .public)")
        return EmptyView()
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

#if DEBUG
#Preview("DynamicUI") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "VStack",
            "children": [
                { "type": "Text", "title": "DynamicUI preview" },
                { "type": "Button", "title": "Action" },
                { "type": "Toggle", "title": "Enabled", "defaultValue": true }
            ]
        }
        """)
}
#endif
