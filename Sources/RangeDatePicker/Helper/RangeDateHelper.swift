//
//  File.swift
//  RangeDatePicker
//
//  Created by Gregory Hoareau on 05/10/2025.
//

import SwiftUI

public class RangeDateHelper {
    private static let datePickerComponents: Set<Calendar.Component> = [.calendar, .era, .year, .month, .day]
    
    public static func filledDatesRange(between selectedDates: Set<DateComponents>, calendar: Calendar) -> Set<DateComponents> {
        let dates = selectedDates.compactMap { calendar.date(from: $0) }
        guard let startDate = dates.min(), let endDate = dates.max() else {
            return selectedDates
        }
        
        var result: Set<DateComponents> = []
        var date = startDate
        while date <= endDate {
            result.insert(calendar.dateComponents(datePickerComponents, from: date))
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: date) else { break }
            date = nextDate
        }
        
        return result
    }
}
