//
//  DynamicDatePicker.swift
//  DynamicUI
//
//  Created by Wesley de Groot on 20/08/2026.
//  https://wesleydegroot.nl
//
//  https://github.com/0xWDG/DynamicUI
//  MIT LICENCE

import Foundation
import SwiftUI

/// DynamicUI: DatePicker
struct DynamicDatePicker: View {
    @Environment(\.internalDynamicUIEnvironment)
    private var dynamicUIEnvironment

    @State private var state: Date

    private let component: DynamicUIComponent
    private let range: ClosedRange<Date>

    init(_ component: DynamicUIComponent) {
        let minimum = DynamicUIDateCoding.date(from: component.minimum) ?? .distantPast
        let maximum = max(DynamicUIDateCoding.date(from: component.maximum) ?? .distantFuture, minimum)
        let initial = DynamicUIDateCoding.date(from: component.defaultValue) ?? Date()

        self._state = State(initialValue: min(max(initial, minimum), maximum))
        self.component = component
        self.range = minimum...maximum
    }

    @ViewBuilder
    var body: some View {
#if os(tvOS)
        EmptyView()
#elseif os(watchOS)
        if #available(watchOS 10.0, *) {
            datePicker
        } else {
            Text(state, style: .date)
                .accessibilityLabel(component.title ?? "Date")
                .set(modifiers: component)
        }
#else
        datePicker
#endif
    }

#if !os(tvOS)
    @available(watchOS 10.0, *)
    private var datePicker: some View {
        DatePicker(
            component.title ?? "Date",
            selection: $state,
            in: range,
            displayedComponents: displayedComponents
        )
        .dynamicUIOnChange(of: state, action: sendUpdate)
        .set(modifiers: component)
    }

    @available(watchOS 10.0, *)
    private var displayedComponents: DatePickerComponents {
        switch component.parameters?["displayedComponents"]?.toString() {
        case "date":
            return .date
        case "hourAndMinute":
            return .hourAndMinute
        default:
            return [.date, .hourAndMinute]
        }
    }
#endif

    private func sendUpdate(_ date: Date) {
        var updatedComponent = component
        updatedComponent.state = .string(DynamicUIDateCoding.string(from: date))
        dynamicUIEnvironment.sendUpdate(updatedComponent)
    }
}

private enum DynamicUIDateCoding {
    static let formatter = ISO8601DateFormatter()

    static func date(from value: AnyCodable?) -> Date? {
        if let seconds = value?.toDouble() {
            return Date(timeIntervalSince1970: seconds)
        }
        return date(from: value?.toString())
    }

    static func date(from value: String?) -> Date? {
        value.flatMap(formatter.date(from:))
    }

    static func string(from date: Date) -> String {
        formatter.string(from: date)
    }
}

#if DEBUG
#Preview("DatePicker") {
    DynamicUIPreviewFixtures.view("""
        {
            "type": "DatePicker",
            "title": "Starts",
            "defaultValue": "2026-08-20T09:00:00Z",
            "parameters": {
                "displayedComponents": "dateAndTime"
            }
        }
        """)
}
#endif
