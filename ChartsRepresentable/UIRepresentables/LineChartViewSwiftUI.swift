//
//  LineChartViewSwiftUI.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 02/07/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import SwiftUI
import Charts

struct LineChartViewSwiftUI:UIViewRepresentable {
    
    @Binding var chartData:LineChartData
    var labelsCount:Int
    
    func makeUIView(context: Context) -> LineChartView {
        let bcxv = LineChartView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        bcxv.data = chartData

        
        bcxv.animate(yAxisDuration: 1)
        bcxv.xAxis.labelCount = labelsCount
        
        let xaxis = bcxv.xAxis
        xaxis.valueFormatter = TimestampAxisValueFormatter()
        xaxis.labelPosition = .bottom
        
        return bcxv
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    class Coordinator : NSObject, ObservableObject {
        

        
        var parent: LineChartViewSwiftUI
        
        init(_ uiTextView: LineChartViewSwiftUI) {
            self.parent = uiTextView
        }
        
        
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = self.chartData
    }
}
