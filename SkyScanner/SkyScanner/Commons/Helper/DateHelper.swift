//
//  DateHelper.swift
//  MobileTestApp
//
//  Created by Nisum on 1/6/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit

enum DateFormats: String {
    case timestamp = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case dayName = "EEEE"
    case dayWithNameAndNumber = "EEEE d"
    case monthName = "MMMM"
}
class DateHelper: NSObject {
    static let sharedInstance = DateHelper()
    static let formatter = DateFormatter()

    func transform(string: String, format: DateFormats = .timestamp) -> Date? {
        DateHelper.formatter.dateFormat = format.rawValue
        return DateHelper.formatter.date(from: string)
    }

    func transform(date: Date, format: DateFormats = .timestamp) -> String {
        return DateHelper.formatter.string(from: date)
    }

    func dayDifference(from date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInYesterday(date) { return "Ayer" } else if calendar.isDateInToday(date) {
            let startOfNow = calendar.startOfDay(for: Date())
            let components = calendar.dateComponents([.hour, .minute], from: startOfNow, to: date)
            let hours = components.hour ?? 0
            var string = ""
            if hours > 0 {
                string = String(hours) + " Hrs"
            }
            let minutes = components.minute ?? 0
            if minutes > 0 {
                if !string.isEmpty {
                    string = string + " - "
                }
                string = string + String(minutes) + " m"
            }
            return string
        } else if calendar.isDateInTomorrow(date) { return "Mañana" } else {
            let startOfNow = calendar.startOfDay(for: Date())
            let components = calendar.dateComponents([.hour, .minute], from: startOfNow, to: date)
            let day = components.day!
            if day < 1 {
                if day > -7 {
                    let dayInWeek = DateHelper.sharedInstance.transform(date: date, format: .dayName)
                    return dayInWeek
                } else {
                    let dayInDate = DateHelper.sharedInstance.transform(date: date, format: .dayWithNameAndNumber)
                    let monthInDate = DateHelper.sharedInstance.transform(date: date, format: .monthName)
                    return dayInDate + " de " + monthInDate
                }
            } else { return "In \(day) days" }
        }
    }
}
