//
//  DynamicUIViewType.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

/// The SwiftUI views that can be constructed from DynamicUI JSON.
enum DynamicUIViewType: String, CaseIterable {
    case asyncImage = "AsyncImage"
    case button = "Button"
    case colorPicker = "ColorPicker"
    case datePicker = "DatePicker"
    case disclosureGroup = "DisclosureGroup"
    case divider = "Divider"
    case form = "Form"
    case gauge = "Gauge"
    case grid = "Grid"
    case gridRow = "GridRow"
    case group = "Group"
    case groupBox = "GroupBox"
    case hSplitView = "HSplitView"
    case hStack = "HStack"
    case image = "Image"
    case label = "Label"
    case lazyHGrid = "LazyHGrid"
    case lazyHStack = "LazyHStack"
    case lazyVGrid = "LazyVGrid"
    case lazyVStack = "LazyVStack"
    case link = "Link"
    case list = "List"
    case menu = "Menu"
    case navigationLink = "NavigationLink"
    case navigationSplitView = "NavigationSplitView"
    case navigationStack = "NavigationStack"
    case navigationView = "NavigationView"
    case picker = "Picker"
    case progressView = "ProgressView"
    case scrollView = "ScrollView"
    case section = "Section"
    case secureField = "SecureField"
    case shareLink = "ShareLink"
    case slider = "Slider"
    case spacer = "Spacer"
    case stepper = "Stepper"
    case tabView = "TabView"
    case text = "Text"
    case textEditor = "TextEditor"
    case textField = "TextField"
    case toggle = "Toggle"
    case vSplitView = "VSplitView"
    case vStack = "VStack"
    case zStack = "ZStack"
}
