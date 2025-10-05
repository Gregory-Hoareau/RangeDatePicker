// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct RangeDatePicker: View {
    @Environment(\.calendar) var calendar
    private let datePickerComponents: Set<Calendar.Component> = [.calendar, .era, .year, .month, .day]
    
    let title: LocalizedStringKey
    @Binding var dates: Set<DateComponents>
    
    var datesBinding: Binding<Set<DateComponents>> {
        Binding(get: { dates }, set: dateBindingSetter)
    }
    
    var body: some View {
        MultiDatePicker(title, selection: datesBinding)
    }
    
    private func dateBindingSetter(_ newValue: Set<DateComponents>) {
        // Selecting a date
        if let addedDate = newValue.subtracting(dates).first {
            switch newValue.count {
            case 1:
                // First tap : only one date is selected, we use it as our anchor
                dates = newValue
            case 2:
                // Second tap : A different date is selected, we fill the range between the two dates
                dates = filledDatesRange(between: newValue)
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
    
    private func filledDatesRange(between selectedDates: Set<DateComponents>) -> Set<DateComponents> {
        let sortedDates = selectedDates.compactMap { calendar.date(from: $0) }.sorted()
        var datesToAdd: [DateComponents] = []
        
        if let startDate = sortedDates.first, let endDate = sortedDates.last {
            var currentDate = startDate
            while currentDate < endDate {
                if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                    if !sortedDates.contains(nextDate) {
                        datesToAdd.append(calendar.dateComponents(datePickerComponents, from: nextDate))
                    }
                    currentDate = nextDate
                }
            }
        }
        
        return selectedDates.union(datesToAdd)
    }
}
