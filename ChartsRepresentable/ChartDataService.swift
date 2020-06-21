//
//  ChartDataService.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 17/06/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftUI
import Charts

// 

// Schritt 1: Hole dir die Impressions, Installs seit 1.1.20
// Schritt X: In /userstats/ speichern, wenn user APNS erlaubt hat. Ich moechte pro Tag wissen, wieviele User erlaubt haben. Eigentlich waere es moeglich:

// /counters/APNSALLOWANCE/DATE/<Liste w/ ??? // und functions observed das und aktualisiert einen cnt mit dem Wert davon.

// Schritt 2: Convertiere Daten nach /charts
// Schritt 3: Hole die Daten dort her
// Schritt 4: Stelle ueber ein Funktions sicher, dass die Daten dort automatisch hinkommen, damit wir das nicht in

class ChartDataService:ObservableObject {
    
  //  @ObservedObject var test = ""
    // Generate Example Data
    
    static func generateChartData() -> BarChartData {
         
         
               
               let start = 1592647740
               // i ist einfach nur ein counter, der von start an hoch zaehlt.
               let yVals = (start..<start+20+1).map { (i) -> BarChartDataEntry in
                
                   let mult = 5 + 1
                   let val = Double(arc4random_uniform(10))
                   return BarChartDataEntry(x: Double(i), y: val)
               }
        
               /*
               var set1: BarChartDataSet! = nil
               if let set = chartView.data?.dataSets.first as? BarChartDataSet {
                   set1 = set
                   set1.replaceEntries(yVals)
                   chartView.data?.notifyDataChanged()
                   chartView.notifyDataSetChanged()
               } else {
                   set1 = BarChartDataSet(entries: yVals, label: "The year 2017")
                   set1.colors = ChartColorTemplates.material()
                   set1.drawValuesEnabled = false
                   
                   let data = BarChartData(dataSet: set1)
                   data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                   data.barWidth = 0.5 // MFE 0.9
                   chartView.data = data
               }
        */
               
               let set1 = BarChartDataSet(entries: yVals, label: "The year 2017")
                let data = BarChartData(dataSet: set1)
                data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                data.barWidth = 0.5 // MFE 0.9
                return data
               

    
     }
    
    static func getImpressionsMB(completion:@escaping(_ barChartData:BarChartData)->Void) {
        let startDate = "2020-06-01"
        let endDate = Date().todayYMD
        let statsRef = TKDatabase.todo().reference(withPath: "stats")
        var todoDatabaseData = [TodoDatabaseData]()
        
        var dataEntries: [BarChartDataEntry] = []
        
        statsRef.queryOrderedByKey().queryStarting(atValue: startDate).queryEnding(atValue: endDate).observeSingleEvent(of: .value) { (snap) in
            
           print("Chart has found \(snap.childrenCount)")
                
            for snap in snap.children {
                
                if let snap = snap as? DataSnapshot {
                    if let stat:Stat = try!snap.decoded() {
                        let value:Double = stat.MB.itc_impressionsTotal ?? 0
                        let todoDataValue = TodoDatabaseData(dateString: snap.key, value: value)
                        todoDatabaseData.append(todoDataValue)
                    }
                }
            }
            
            
            
            for i in 0..<todoDatabaseData.count {
                let dataEntry = BarChartDataEntry(x: Double(i), yValues:  [todoDatabaseData[i].value], data: "groupChart")
                dataEntries.append(dataEntry)
            }
            
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "A")
            let chartData = BarChartData(dataSet: chartDataSet)
            
            
            

            
        }
        
    }
    
    static func getTestData(completion:@escaping(_ barChartData:BarChartData)->Void) {
        // Generate Test Data
        
        let start = 1592647740
        let count = 13
        let range:UInt32 = 50
        // i ist einfach nur ein counter, der von start an hoch zaehlt.
        let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
            print(range)
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            return BarChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = BarChartDataSet(entries: yVals, label: "The year 2017")
        let barChartData = BarChartData(dataSet: set1)
        barChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        barChartData.barWidth = 0.5 // MFE 0.9
        completion(barChartData)
    }
    
    // TODO: Nutze diese Funktion nun in der Creation und dann echte Daten und dann
    // andere indizes
    // dann mrtg daten verwenden
    // dann mrtg outfit imitieren
    // ca. 13.00 will ich F.
    static func createBarChartData(from todoDatabaseData:[TodoDatabaseData]) ->  BarChartData {
        
        // 1. Todo data (yyyy-mm-dd => timestamp,value)
        let barChartDataEntries = todoDatabaseData.map({return BarChartDataEntry(x: $0.timeInterval!, y: $0.value)})
        let set1 = BarChartDataSet(entries: barChartDataEntries, label: "The year 2017")
        let barChartData = BarChartData(dataSet: set1)
        barChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        barChartData.barWidth = 0.5 // MFE 0.9
        return barChartData
        
    }
    
    static func getAllImpressions(appshort:String, completion:@escaping(_ barChartData:BarChartData)->Void) {
      

            

              let range   = "all"
              let app     = "MB"
              let type    = "IMPR"

            var values1 = [Double]()
            var values2 = [Double]()
            var values3 = [Double]()
            var values4 = [Double]()
            
            let statsRef = TKDatabase.todo().reference(withPath: "stats")
            let startDate = range == "all" ? "2020-01-01" : Date().thirtyDaysAgoYMD
            let endDate = Date().todayYMD

            
            statsRef.queryOrderedByKey().queryStarting(atValue: startDate).queryEnding(atValue: endDate).observeSingleEvent(of: .value) { (snap) in
                
               print("Chart has found \(snap.childrenCount)")
                    
                for snap in snap.children {
                    
                    if let snap = snap as? DataSnapshot {
                        if let stat:Stat = try!snap.decoded() {
                            switch type {
                            case "IMPR":
                                values1.append(stat.MB.itc_impressionsTotal ?? 0)
                                values2.append(stat.NB.itc_impressionsTotal ?? 0)
                                values3.append(stat.SW.itc_impressionsTotal ?? 0)
                                values4.append(stat.CA.itc_impressionsTotal ?? 0)
//                            case "WLM":
//                                values1.append(stat.MB.who_liked_me_vc_called ?? 0)
//                                values2.append(stat.NB.who_liked_me_vc_called ?? 0)
//                                values3.append(stat.SW.who_liked_me_vc_called ?? 0)
//                                values4.append(stat.CA.who_liked_me_vc_called ?? 0)
                            case "IAPP":
                                values1.append(stat.MB.iapp ?? 0)
                                values2.append(stat.NB.iapp ?? 0)
                                values3.append(stat.SW.iapp ?? 0)
                                values4.append(stat.CA.iapp ?? 0)
                            case "IAP":
                                values1.append(stat.MB.iap ?? 0)
                                values2.append(stat.NB.iap ?? 0)
                                values3.append(stat.SW.iap ?? 0)
                                values4.append(stat.CA.iap ?? 0)
//                            case "SALES":
//                                values1.append(stat.MB.itc_saleseur ?? 0)
//                                values2.append(stat.NB.itc_saleseur ?? 0)
//                                values3.append(stat.SW.itc_saleseur ?? 0)
//                                values4.append(stat.CA.itc_saleseur ?? 0)
//                            case "EUR30":
//                                values1.append(stat.MB.eurlast30 ?? 0)
//                                values2.append(stat.NB.eurlast30 ?? 0)
//                                values3.append(stat.SW.eurlast30 ?? 0)
//                                values4.append(stat.CA.eurlast30 ?? 0)
                            case "INST":
                                values1.append(stat.MB.deviceids ?? 0)
                                values2.append(stat.NB.deviceids ?? 0)
                                values3.append(stat.SW.deviceids ?? 0)
                                values4.append(stat.CA.deviceids ?? 0)
                            case "PRF":
                                values1.append(stat.MB.profile_created ?? 0)
                                values2.append(stat.NB.profile_created ?? 0)
                                values3.append(stat.SW.profile_created ?? 0)
                                values4.append(stat.CA.profile_created ?? 0)
                            case "FCMS":
                                values1.append(stat.MB.fcm_success ?? 0)
                                values2.append(stat.NB.fcm_success ?? 0)
                                values3.append(stat.SW.fcm_success ?? 0)
                                values4.append(stat.CA.fcm_success ?? 0)
                            case "DEL":
                                values1.append(stat.MB.profile_deletions ?? 0)
                                values2.append(stat.NB.profile_deletions ?? 0)
                                values3.append(stat.SW.profile_deletions ?? 0)
                                values4.append(stat.CA.profile_deletions ?? 0)
                            default:
                                print ("error")
                            }
                        }
                    }
                }
                
                var dataEntries: [BarChartDataEntry] = []
                for i in 0..<values1.count {
                    let dataEntry = BarChartDataEntry(x: Double(i), yValues:  [values1[i],values2[i],values3[i],values4[i]], data: "groupChart")
                    dataEntries.append(dataEntry)
                }
                
                let chartDataSet = BarChartDataSet(entries: dataEntries, label: "A")
                
                _   = UIColor(red: 46/255, green: 49/255, blue: 67/255, alpha: 1.0)
                let Yellow           = UIColor(red: 250/255, green: 210/255, blue: 1/255, alpha: 1.0)
                let Orange           = UIColor(red: 242/255, green: 155/255, blue: 18/255, alpha: 1.0)
                    
                chartDataSet.colors = [Yellow, Orange, Yellow, Orange]
                    
                    let chartData = BarChartData(dataSet: chartDataSet)
                completion(chartData)
                    
        }
    }
}

// This data is in the format 2020-02-10 and Double and can convert to TimeInterval / Double
struct TodoDatabaseData {
    
    /// Setter
    var dateString:String
    var value:Double
    var timeInterval:Double? {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        if let date = df.date(from: dateString) {
            return date.timeIntervalSince1970
        }
        return nil
    }
}
