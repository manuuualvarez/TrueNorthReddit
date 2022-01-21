//
//  String+Extension.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/21/22.
//

import Foundation

func timeAgoSinceDate(date:Date, currentDate: Date, numericDates:Bool) -> String {
    let calendar = Calendar.current
    
    let now = currentDate
    let earliest = (now as NSDate).earlierDate(date)
    let latest = (earliest == now) ? date : now
    let components: DateComponents = (calendar as NSCalendar).components([
        NSCalendar.Unit.second,
        NSCalendar.Unit.minute,
        NSCalendar.Unit.hour,
        NSCalendar.Unit.day,
        NSCalendar.Unit.weekOfYear,
        NSCalendar.Unit.month,
        NSCalendar.Unit.year,
    ], from: earliest, to: latest, options: NSCalendar.Options())
    
    if (components.year! >= 2) {
        return "\(String(describing: components.year)) years ago"
    } else if (components.year! >= 1){
        if (numericDates){
            return "1 year ago"
        } else {
            return "Last year"
        }
    } else if (components.month! >= 2) {
        return "\(components.month ?? 0) months ago"
    } else if (components.month! >= 1){
        if (numericDates){
            return "1 month ago"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear ?? 0) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1 week ago"
        } else {
            return "Last week"
        }
    } else if (components.day! >= 2) {
        return "\(components.day ?? 0) days ago"
    } else if (components.day! >= 1){
        if (numericDates){
            return "1 day ago"
        } else {
            return "Yesterday"
        }
    } else if (components.hour! >= 2) {
        return "\(components.hour ?? 0) hours ago"
    } else if (components.hour! >= 1){
        if (numericDates){
            return "1 hour ago"
        } else {
            return "An hour ago"
        }
    } else if (components.minute! >= 2) {
        return "\(components.minute ?? 0) minutes ago"
    } else if (components.minute! >= 1){
        if (numericDates){
            return "1 minute ago"
        } else {
            return "A minute ago"
        }
    } else if (components.second! >= 3) {
        return "\(components.second ?? 0) seconds ago"
    } else {
        return "Just now"
    }
    
}
