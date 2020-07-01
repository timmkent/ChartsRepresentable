//
//  RatingViewPerApp.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 30/06/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import SwiftUI
import Charts

struct RatingViewPerApp:View {
    var app:String
    let labelsCount = 20
    @State var ratings = BarChartData()
    @State var startDate:String = "2020-01-01"
    var body: some View {
        ZStack {
            
            BarChartViewSwiftUI(chartData: self.$ratings, labelsCount: self.labelsCount)
                .onAppear() {
   
//                    ChartDataService.getRatings(startDate: self.startDate, appshort: self.appshort, key: self.key) { barChartData  in
//                        self.ratings = barChartData
                        
//                    }
            }
            
            Text(app)
            Spacer()
            
        }
    }
}
