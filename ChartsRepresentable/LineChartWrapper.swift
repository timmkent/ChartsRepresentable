//
//  LineChartWrapper.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 02/07/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import SwiftUI
import Charts

struct LineChartWrapper: View {
    var startDate:String
    var appshort:String
    var key:String
    @State var impressions = LineChartData()
    let labelsCount = 20
    var body: some View {
        ZStack {
            
            LineChartViewSwiftUI(chartData: self.$impressions, labelsCount: self.labelsCount)
                .onAppear() {
                   
                    if self.key == "test" {
                        
                        //1. create LineChartDataEntries
                        //2. create LineChartDataSet (using Entries)
                        //3. create LindeChartData (using set)
                        var chartDataEntries = [ChartDataEntry]()
                        for entry in 0...20 {
                            let entry = ChartDataEntry(x: Double(entry), y: Double(entry))
                            chartDataEntries.append(entry)
                        }
                        
                        let lineChartDataSet = LineChartDataSet(entries: chartDataEntries)
                        

                        
                        let set1 = LineChartDataSet(entries: chartDataEntries)
                        let barChartData = LineChartData(dataSet: set1)
                        barChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                      //  barChartData.barWidth = 0.5 // MFE 0.9
                        
                        
                        
                        self.impressions = barChartData
                        
                        
                        
                    }
                    
                            
                        
                    

            }
            
            Text("APP:\(appshort) KEY:\(key)")
            Spacer()
        }
    }
}

