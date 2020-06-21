//
//  ChartRepresentable.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 17/06/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

// AUFGABE: bringe die Tagesanzeige ans laufen. Da gibt es referenmzen zu im Internate.

// mache ein install 

import SwiftUI
import Charts

struct BarChartViewSwiftUI:UIViewRepresentable {
    
    @Binding var chartData:BarChartData
    @Binding var dateStrings:[String]
    
    func makeUIView(context: Context) -> BarChartView {
        let bcxv = BarChartView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        bcxv.data = chartData
        
        // Chart Configuration
        bcxv.barData?.dataSets.first?.drawValuesEnabled = true
        bcxv.barData?.dataSets.first?.valueFormatter = LargeValueFormatter()
        
        bcxv.animate(yAxisDuration: 3)
        bcxv.xAxis.labelCount = 20
        
        let xaxis = bcxv.xAxis
        xaxis.valueFormatter = TimestampAxisValueFormatter()
        xaxis.labelPosition = .bottom
        
        return bcxv
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    class Coordinator : NSObject, IAxisValueFormatter, ObservableObject {
        
        // todo: wir brauchen wahrscheinlich hier nochmal eine Kopie der Daten.
        
        var parent: BarChartViewSwiftUI
        
        init(_ uiTextView: BarChartViewSwiftUI) {
            self.parent = uiTextView
        }
        
        
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            
          
       
            let dateStrig = parent.dateStrings[Int(value)]
             let df = DateFormatter()
             df.dateFormat = "yyyy-MM-dd"
             let date = df.date(from: dateStrig)
             df.dateFormat = "dd/MM"
             if let date = date {
             let weekday = Calendar.current.component(.weekday, from: date)
             let weekdayShort = df.shortWeekdaySymbols[weekday - 1]
             let dateString = df.string(from: date)
             let string = "\(weekdayShort)\n\(dateString)"
             return string
             } else {
             return "err"
             }
            
        }
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        
        uiView.data = self.chartData
        print("updateUIView")
    }
}


// 1592647740

func generateEpochExampleData() -> [Double] {
    var results = [Double]()
    for i in 1...20 {
        let oneDaySeconds = Double(86400)
        results.append(oneDaySeconds*Double(i))
    }
    return results
}

class TimestampAxisValueFormatter: NSObject, IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        print("Converting \(value) ...")
        let df = DateFormatter()
         let date = Date(timeIntervalSince1970: value)
         df.dateFormat = "dd/MM"
         let weekday = Calendar.current.component(.weekday, from: date)
         let weekdayShort = df.shortWeekdaySymbols[weekday - 1]
         let dateString = df.string(from: date)
         let string = "\(weekdayShort)\n\(dateString)"
         return string
    }
}
