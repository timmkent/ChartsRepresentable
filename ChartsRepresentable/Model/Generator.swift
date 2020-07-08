//
//  Generator.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 03/07/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import Foundation
// Data Generator

class Generator {
    class func generateData(startDate:String, withRandomValuesFrom min:Double, to max: Double)  -> [(String,Double)] {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let startDate = df.date(from: startDate)!
        let endDate = Date()
        
        let cal = Calendar.current
        // Get the date of 50 years ago today
       // let stopDate = cal.date(byAdding: .year, value: -50, to: Date())!

        // We want to find dates that match on Sundays at midnight local time
        var comps = DateComponents()
        comps.hour = 00
        comps.minute = 00

        
        var resultDateStrings = [(String,Double)]()
        // Enumerate all of the dates
        cal.enumerateDates(startingAfter: startDate, matching: comps, matchingPolicy: .previousTimePreservingSmallerComponents, repeatedTimePolicy: .first, direction: .forward) { (date, match, stop) in
            if let date = date {
                if date > endDate {
                    stop = true // We've reached the end, exit the loop
                } else {
                    resultDateStrings.append((df.string(from: date),Double.random(in: min...max)))
                }
            }
        }
        
        return resultDateStrings
    }
}
