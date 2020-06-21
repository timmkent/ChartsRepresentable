//
//  ContentView.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 17/06/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import SwiftUI
import Charts
// show different sheets using an ENUM
// Updatre geht nicht wirklich!


struct ContentView: View {

    @State private var impressions = BarChartData()
    @State private var stringData = [String]()
 //   @State private var impressionsNB = BarChartData()
    
    // Mache das Protokoll (ohne Nachdenken, einfach die PreSexChecklist durchziehen)
    // Dann soll er vorbei kommen und dich ficken und dann ist fertig.
    // Dann machen die PostSexChecklist: War es schoen, was war schoen, hat was weh getan, hat
    // PRE Checklist (die immer funktioniert, egal ob wir gerade g. haben oder nicht)
    // 1) Spuelen bis 5x sauberes wasser kommt
    // 2) 5x mit etwas penis grossem langsam rein und schnell raus
    // eigentlich kann das doch gar nicht "nicht" gehen
    // Nimm einen stricher, der dich regelmaessig, damit du die angst verlierst
    // und es zur "sicheren" routine wird
    // nimm leute per gr
    // finde raus, was dir wirklich gefaellt (ohen alk und ohne dr)
    // ohne drama ohne alles
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: BarChartViewSwiftUI(chartData: self.$impressions, dateStrings: self.$stringData), label: { Text ("Impressions")})
                .navigationBarTitle("Impressions")
                    .onAppear() {
                        
                        ChartDataService.getTestData { barChartData  in
                            self.impressions = barChartData
                        }
                          ChartDataService.getImpressionsMB { barChartData  in

                              
                        
                          }
                }
            }
            
            VStack {
                Text("Select")
                
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
//                    ChartDataService.getAllImpressions(appshort: "") { (data) in
//                        self.impressions = data
//                    }
                    

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
