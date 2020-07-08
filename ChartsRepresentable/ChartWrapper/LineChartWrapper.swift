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

                        ChartDataService.generateImpressionsExample { (todoDatabaseData) in
                            let chartDataEntries = ChartDataService.convertToLineChartDataEntry(todoDatabaseData: todoDatabaseData)
                              let set1 = LineChartDataSet(entries: chartDataEntries)
                              let barChartData = LineChartData(dataSet: set1)
                              barChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                              self.impressions = barChartData
                        }
                    }
            }
            
            Text("APP:\(appshort) KEY:\(key)")
            Spacer()
        }
    }
}

