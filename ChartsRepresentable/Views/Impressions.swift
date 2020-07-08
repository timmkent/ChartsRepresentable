//
//  Impressions.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 03/07/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import SwiftUI
import Charts

struct Impressions: View {
    var startDate = "2020-01-01"
    var appshort:String
    var key:String
    @State var impressions = BarChartData()
    @State var sa_impressions = BarChartData()
    let labelsCount = 20
    var body: some View {
        VStack {
            
            BarChartViewSwiftUI(chartData: self.$impressions, labelsCount: self.labelsCount)
                .onAppear() {
                    if self.key == "test" {
                        print("Testing Mode")
                        
                        var barChartDataEntries = [BarChartDataEntry]()
                        for entry in 0...20 {
                            
                            let barChatData = BarChartDataEntry(x: Double(entry), y:Double(entry))
                            barChartDataEntries.append(barChatData)
                            
                        }
                        
                        let set1 = BarChartDataSet(entries: barChartDataEntries, label: "Test-Data-Set-Bar")
                        let barChartData = BarChartData(dataSet: set1)
                        barChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                        barChartData.barWidth = 0.5 // MFE 0.9
                        
                        
                        
                        self.impressions = barChartData
                        
                        
                        
                    } else if ["gay","gay_chat","gay_dating","gay_hookup"].contains(self.key) {
                        ChartDataService.getChartDatabaseStatsRanks(startDate: self.startDate, appshort: self.appshort, key: self.key) { barChartData  in
                            self.impressions = barChartData
                        }
                    } else {
                        ChartDataService.getChartDatabaseStats(startDate: self.startDate, appshort: self.appshort, key: self.key) { barChartData  in
                            self.impressions = barChartData
                            
                        }
                    }

            }
        }.navigationBarTitle("\(appshort): Impressions")
    }
}
