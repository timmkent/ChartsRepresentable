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
    var labelsCount:Int
    
    func makeUIView(context: Context) -> BarChartView {
        let bcxv = BarChartView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        bcxv.data = chartData
        
        // Chart Configuration
        bcxv.barData?.dataSets.first?.drawValuesEnabled = true
        bcxv.barData?.dataSets.first?.valueFormatter = LargeValueFormatter()
        
        bcxv.animate(yAxisDuration: 1)
        bcxv.xAxis.labelCount = labelsCount
        
        let xaxis = bcxv.xAxis
        xaxis.valueFormatter = TimestampAxisValueFormatter()//ChartXAxisFormatter() //TimestampAxisValueFormatter()
        xaxis.labelPosition = .bottom
        
        return bcxv
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    class Coordinator : NSObject, ObservableObject {
        

        
        var parent: BarChartViewSwiftUI
        
        init(_ uiTextView: BarChartViewSwiftUI) {
            self.parent = uiTextView
        }
        
        
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        
        uiView.data = self.chartData

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
        let df = DateFormatter()
         let date = Date(timeIntervalSince1970: value*86400)
         df.dateFormat = "dd/MM"
         let weekday = Calendar.current.component(.weekday, from: date)
         let weekdayShort = df.shortWeekdaySymbols[weekday - 1]
         let dateString = df.string(from: date)
         let string = "\(weekdayShort)\n\(dateString)"
         return string
    }
}

class ChartXAxisFormatter: NSObject {
    fileprivate var dateFormatter: DateFormatter?
    fileprivate var referenceTimeInterval: TimeInterval?

    convenience init(referenceTimeInterval: TimeInterval, dateFormatter: DateFormatter) {
        self.init()
        self.referenceTimeInterval = referenceTimeInterval
        self.dateFormatter = dateFormatter
    }
}


extension ChartXAxisFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let dateFormatter = dateFormatter,
        let referenceTimeInterval = referenceTimeInterval
        else {
            return ""
        }

        let date = Date(timeIntervalSince1970: value * 3600 * 24 + referenceTimeInterval)
        return dateFormatter.string(from: date)
    }

}
