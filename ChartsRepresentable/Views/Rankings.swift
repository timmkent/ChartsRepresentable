//
//  Rankings.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 04/07/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import SwiftUI
import Charts

struct Rankings: View {
    var app:String
    @State var impressions = LineChartData()
    let labelsCount = 20
    var body: some View {
        VStack {
            LineChartViewSwiftUI(chartData: self.$impressions, labelsCount: self.labelsCount)
                .onAppear() {
                    
                    
                    
                    //1. create LineChartDataEntries
                    //2. create LineChartDataSet (using Entries)
                    //3. create LindeChartData (using set)
                    ChartDataService.getRankings(startDate: "2020-01-01", appshort: self.app, keyword: "gay") { todoDatabaseData in
                        let chartDataEntries = ChartDataService.convertToLineChartDataEntry(todoDatabaseData: todoDatabaseData)
                        let set1 = LineChartDataSet(entries: chartDataEntries)
                        
                        ChartDataService.getRankings(startDate: "2020-01-01", appshort: self.app, keyword: "gay_chat") { todoDatabaseData in
                            let chartDataEntries2 = ChartDataService.convertToLineChartDataEntry(todoDatabaseData: todoDatabaseData)
                            let set2 = LineChartDataSet(entries: chartDataEntries2)
                            
                            ChartDataService.getRankings(startDate: "2020-01-01", appshort: self.app, keyword: "gay_dating") { todoDatabaseData in
                                let chartDataEntries3 = ChartDataService.convertToLineChartDataEntry(todoDatabaseData: todoDatabaseData)
                                let set3 = LineChartDataSet(entries: chartDataEntries3)
                                
                                ChartDataService.getRankings(startDate: "2020-01-01", appshort: self.app, keyword: "gay_hookup") { todoDatabaseData in
                                    let chartDataEntries4 = ChartDataService.convertToLineChartDataEntry(todoDatabaseData: todoDatabaseData)
                                    let set4 = LineChartDataSet(entries: chartDataEntries4)

                                    self.formatDataset(label: "gay", color: green, dataset: set1)
                                    self.formatDataset(label: "gay_chat", color: blue, dataset: set2)
                                    self.formatDataset(label: "gay_dating", color: red, dataset: set3)
                                    self.formatDataset(label: "gay_hookup", color: orange, dataset: set4)
                                    
                                    
                                    let barChartData = LineChartData(dataSets: [set1,set2,set3,set4])
                                    barChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                                    self.impressions = barChartData
                                }
                            }
                        }
                    }
            }
        }.navigationBarTitle("\(app): Keyword Rankings")

    }
    
    func formatDataset(label:String, color:UIColor, dataset:LineChartDataSet) {
        let white = UIColor(named: "white")!
        dataset.circleHoleRadius = 3.0
        dataset.circleRadius = 4.0
        dataset.circleColors = [white]
        dataset.circleHoleColor = color
        dataset.colors = [color]
        dataset.label = label
    }
}

struct Rankings_Previews: PreviewProvider {
    static var previews: some View {
        Rankings(app: "test")
    }
}
