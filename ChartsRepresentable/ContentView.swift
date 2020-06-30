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
    let startDate = "2020-06-01"
    let apps = ["MB","NB","SW","CA","WE"]
    let keys = ["itc_impressionsTotal","deviceids","app_exception","deletionratio","eurlast30","fcm_deleted","func_err","fcm_success","iap","iapp","in_app_purchase","itc_averageRating","itc_crashes","itc_iaps","itc_sales","itc_units","profile_created","profile_deletions","sa_impressions","sa_localSpend","sa_installs","uid_created","who_liked_me_vc_called"]
    var body: some View {
        NavigationView {
            List {
                ForEach(apps, id:\.self) { app in
                    NavigationLink(app, destination: ListViewPerApp(app: app))
                    .navigationBarTitle(app)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


    struct ListViewPerApp: View {
        let startDate = "2020-06-01"
        var app:String
        let keys = ["itc_impressionsTotal","deviceids","app_exception","deletionratio","eurlast30","fcm_deleted","func_err","fcm_success","iap","iapp","in_app_purchase","itc_averageRating","itc_crashes","itc_iaps","itc_sales","itc_units","profile_created","profile_deletions","sa_impressions","sa_localSpend","sa_installs","uid_created","who_liked_me_vc_called","gay","gay_chat","gay_dating","gay_hookup"]
        var body: some View {
                List {
                    ForEach(keys, id:\.self) { key in
                        NavigationLink(destination: BarChartWrapper(startDate: self.startDate, appshort: self.app, key: key), label: { Text (key)})
                            
                            .navigationBarTitle(key)
              //          BarChartWrapper(startDate: self.startDate, appshort: "MB", key: key).frame(height: 400)
                    }
                    

                }

            
        }
    }
        

struct BarChartWrapper: View {
    var startDate:String
    var appshort:String
    var key:String
    @State var impressions = BarChartData()
    let labelsCount = 20
    var body: some View {
        ZStack {
            
            BarChartViewSwiftUI(chartData: self.$impressions, labelsCount: self.labelsCount)
                .onAppear() {
                    if ["gay","gay_chat","gay_dating","gay_hookup"].contains(self.key) {
                        ChartDataService.getChartDatabaseStatsRanks(startDate: self.startDate, appshort: self.appshort, key: self.key) { barChartData  in
                            self.impressions = barChartData
                            
                        }
                    } else {
                        ChartDataService.getChartDatabaseStats(startDate: self.startDate, appshort: self.appshort, key: self.key) { barChartData  in
                            self.impressions = barChartData
                            
                        }
                    }

            }
            
            Text(appshort)
            Spacer()
            
        }

    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
