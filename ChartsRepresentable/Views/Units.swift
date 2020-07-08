//
//  Units.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 08/07/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import Foundation

import SwiftUI
import Charts

struct Units: View {
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
                    
                    ChartDataService.getChartDatabaseStats(startDate: self.startDate, appshort: self.appshort, key: self.key) { barChartData  in
                        self.impressions = barChartData
                        
                    }
                    
                    
            }
        }.navigationBarTitle("\(appshort): Units")
    }
}
