// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct RangeDatePicker: View {
    @Environment(\.calendar) var calendar
    
    let title: LocalizedStringKey
    @Binding var dates: Set<DateComponents>
    
    var datesBinding: Binding<Set<DateComponents>> {
        Binding {
            dates
        } set: { newValue in
            if let addedDate = newValue.subtracting(dates).first {
                switch newValue.count {
                case 1:
                    // First tap : only one date is selected, we use it as our anchor
                    dates = newValue
                case 2:
                    // Second tap : A different date is selected, we fill the range between the two dates
                    dates = RangeDateHelper.filledDatesRange(between: newValue, calendar: calendar)
                default:
                    // We keep the last date selected as the anchor
                    dates = [addedDate]
                }
                return
            }
            
            // Unselecting a date
            if dates.count > 1, let removedDate = dates.subtracting(newValue).first {
                // Keep the unselected date as the new anchor for the range
                dates = [removedDate]
                return
            }
            
            dates = []
        }
    }
    
    public init(_ title: LocalizedStringKey = "", dates: Binding<Set<DateComponents>>) {
        self.title = title
        self._dates = dates
    }
    
    public var body: some View {
        MultiDatePicker(title, selection: datesBinding)
    }
}
