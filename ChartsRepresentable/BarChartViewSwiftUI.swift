//
//  ChartRepresentable.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 17/06/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

// AUFGABE: bringe die Tagesanzeige ans laufen. Da gibt es referenmzen zu im Internate.



import SwiftUI


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
        xaxis.valueFormatter = context.coordinator
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


