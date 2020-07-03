//
//  CombinedChartWrapper.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 02/07/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//


import SwiftUI
import Charts

struct CombinedChartWrapper: View {
    var startDate:String
    var appshort:String
    var key:String
    @State var impressions = CombinedChartData()
    let labelsCount = 20
    var body: some View {
        ZStack {
            
            CombinedChartViewSwiftUI(chartData: self.$impressions, labelsCount: self.labelsCount)
                .onAppear() {
                   


                    func setChart(xValues: [Int], yValuesLineChart: [Double], yValuesBarChart: [Double]) {
                       // combinedChart.noDataText = "Please provide data for the chart."

                        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
                        var yVals2 : [BarChartDataEntry] = [BarChartDataEntry]()

                        for i in 0..<xValues.count {

                            yVals1.append(ChartDataEntry(x: Double(i), y: Double(i)))
                            yVals2.append(BarChartDataEntry(x: Double(i), y: yValuesBarChart[i] - 1))
                            

                        }

                        let lineChartSet = LineChartDataSet(entries: yVals1, label: "Line Data")
                        let barChartSet: BarChartDataSet = BarChartDataSet(entries: yVals2, label: "Bar Data")

                        let data: CombinedChartData = CombinedChartData(dataSets: [lineChartSet,barChartSet])

                        self.impressions = data

                    }
                       
                    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
                    let unitsSold = [2.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 17.0, 2.0, 4.0, 5.0, 4.0]
                    setChart(xValues: [0,1,2,3,4,5,6,7], yValuesLineChart:  unitsSold, yValuesBarChart: unitsSold)
            }
            
            Text("APP:\(appshort) hier KEY:\(key)")
            Spacer()
        }
    }
}

