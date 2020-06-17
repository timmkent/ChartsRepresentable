//
//  ContentView.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 17/06/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import SwiftUI

// show different sheets using an ENUM
// Updatre geht nicht wirklich!


struct ContentView: View {

    @State private var impressions = BarChartData()
    @State private var stringData = [String]()
 //   @State private var impressionsNB = BarChartData()
    
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: BarChartViewSwiftUI(chartData: self.$impressions, dateStrings: self.$stringData), label: { Text ("Impressions")})
                .navigationBarTitle("Impressions")
            }
            
            VStack {
                Text("Select")
                
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
//                    ChartDataService.getAllImpressions(appshort: "") { (data) in
//                        self.impressions = data
//                    }
                    
                    ChartDataService.getImpressionsMB { (data, stingData)  in
                        self.impressions = data
                        self.stringData = stingData
                    }
                }
            }
        }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
