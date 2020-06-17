//
//  Extension+Date.swift
//  myBoy
//
//  Created by Marc Felden on 29/01/2019.
//  Copyright © 2019 Marc Felden. All rights reserved.
//

import Foundation
extension Int {
    var timeIntervalDOB:Int {
        let halfAYearSeconds = 365 * 24 * 60 * 30
        let secondsLived = Int(self) * 365 * 24 * 60 * 60 + halfAYearSeconds
        return Date().timeIntervalSecondsSince1970 - secondsLived
    }
}
extension Date {
    var yesterdayYMD:String {
        let today = Date().addingTimeInterval(-60*60*24)
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: today)
        return date
    }
    var thirtyDaysAgoYMD:String {
        let today = Date().addingTimeInterval(-60*60*24*30)
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: today)
        return date
    }
    var dayBeforeYesterdayYMD:String {
        let today = Date().addingTimeInterval(-60*60*24*2)
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: today)
        return date
    }
    var todayYMD:String {
        let today = Date()
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: today)
        return date
    }
    var todayHHMM:String {
        let today = Date()
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "hh:mm"
        let date = df.string(from: today)
        return date
    }
    var timeIntervalSecondsSince1970:Int {
        let ti = Int(self.timeIntervalSince1970)
        return ti
    }
    var timeIntervalMilliSecondsSince1970:Int64 {
        let ti = Int64(self.timeIntervalSince1970*1000)
        return ti
    }

    var toYYYMMDDforUTC:String {
        let today = self
        
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: today)
        return date
    }
    var toHHMMssforUTC:String {
        let today = self
        
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "HH:mm:ss"
        let date = df.string(from: today)
        return date
    }
    var toHHMMss:String {
        let today = self
        
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let date = df.string(from: today)
        return date
    }
    var secondsPassedSinceMidnight:Int {
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "YYYY-MM-dd"
        let todayString = df.string(from: Date())
        let midnight = todayString + " 00:00"
        df.dateFormat = "YYYY-MM-dd hh:mm"
        let midnightDate = df.date(from: midnight)
        return Date().timeIntervalSecondsSince1970 - midnightDate!.timeIntervalSecondsSince1970 
    }
    var percentagePassedOfDay:Double {
        return Double(secondsPassedSinceMidnight) / Double(86400)
    }
}
