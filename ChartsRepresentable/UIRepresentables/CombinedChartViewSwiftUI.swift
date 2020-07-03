//
//  CombinedChartViewSwiftUI.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 02/07/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import SwiftUI
import Charts


struct CombinedChartViewSwiftUI:UIViewRepresentable {
    
    @Binding var chartData:CombinedChartData
    var labelsCount:Int
    
    func makeUIView(context: Context) -> CombinedChartView {
        let bcxv = CombinedChartView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        bcxv.data = chartData
        
        // Chart Configuration
        // not applicable for line charts?
        //bcxv.barData?.dataSets.first?.drawValuesEnabled = true
        //bcxv.barData?.dataSets.first?.valueFormatter = LargeValueFormatter()
        /*
        bcxv.animate(yAxisDuration: 1)
        bcxv.xAxis.labelCount = labelsCount
        
        let xaxis = bcxv.xAxis
        xaxis.valueFormatter = TimestampAxisValueFormatter()//ChartXAxisFormatter() //TimestampAxisValueFormatter()
        xaxis.labelPosition = .bottom
        */
        return bcxv
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    class Coordinator : NSObject, ObservableObject {
        

        
        var parent: CombinedChartViewSwiftUI
        
        init(_ uiTextView: CombinedChartViewSwiftUI) {
            self.parent = uiTextView
        }
        
        
    }
    
    func updateUIView(_ uiView: CombinedChartView, context: Context) {
        uiView.data = self.chartData
    }
}
