//
//  ChartViewController.swift
//  ChartTests
//
//  Created by Marc Felden on 11/12/2019.
//  Copyright © 2019 Marlin Brandin. All rights reserved.
//

import UIKit

import FirebaseDatabase

class ChartViewController:UIViewController {
    
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var chartTitel: UILabel!
    @IBOutlet weak var change: UILabel!
    @IBOutlet weak var rangeSelection: UISegmentedControl!
    @IBOutlet weak var appSelection: UISegmentedControl!
    @IBOutlet weak var typeSelection: UISegmentedControl!
    
    var totalText = ""
    var titleText = ""
    var changeText = ""
    var previousSum = 0.0
    var curentSum = 0.0
    var days = 0.0
    var appshort = ""
    var key = ""
    var axisFormatDelegate: IAxisValueFormatter?
    
    enum Selection:Int {
        case all
        case thirtyDays
    }
    
    var datas:[TKData]! {
        didSet {
            self.updateChartWithData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureChart()
//        axisFormatDelegate = self
        updateUI()
    }
    
    func updateUIAll() {
        
       
            
        let range   = rangeSelection.titleForSegment(at: rangeSelection.selectedSegmentIndex)
        _     = appSelection.titleForSegment(at: appSelection.selectedSegmentIndex)
        let type    = typeSelection.titleForSegment(at: typeSelection.selectedSegmentIndex)
        
        self.chartTitel.text = "\(type!) - all"
        
        let statsRef = TKDatabase.todo().reference(withPath: "stats")
        let startDate = range == "all" ? "2020-01-01" : Date().thirtyDaysAgoYMD
        let endDate = Date().todayYMD
        
        

        var values1 = [Double]()
        var values2 = [Double]()
        var values3 = [Double]()
        var values4 = [Double]()
        
        statsRef.queryOrderedByKey().queryStarting(atValue: startDate).queryEnding(atValue: endDate).observeSingleEvent(of: .value) { (snap) in
           
                
            for snap in snap.children {
                if let snap = snap as? DataSnapshot {
                    if let stat:Stat = try!snap.decoded() {
                        switch type {
                        case "IMPR":
                            values1.append(stat.MB.itc_impressionsTotal ?? 0)
                            values2.append(stat.NB.itc_impressionsTotal ?? 0)
                            values3.append(stat.SW.itc_impressionsTotal ?? 0)
                            values4.append(stat.CA.itc_impressionsTotal ?? 0)
                        case "WLM":
                            values1.append(stat.MB.who_liked_me_vc_called ?? 0)
                            values2.append(stat.NB.who_liked_me_vc_called ?? 0)
                            values3.append(stat.SW.who_liked_me_vc_called ?? 0)
                            values4.append(stat.CA.who_liked_me_vc_called ?? 0)
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
                        case "SALES":
                            values1.append(stat.MB.itc_saleseur ?? 0)
                            values2.append(stat.NB.itc_saleseur ?? 0)
                            values3.append(stat.SW.itc_saleseur ?? 0)
                            values4.append(stat.CA.itc_saleseur ?? 0)
                        case "EUR30":
                            values1.append(stat.MB.eurlast30 ?? 0)
                            values2.append(stat.NB.eurlast30 ?? 0)
                            values3.append(stat.SW.eurlast30 ?? 0)
                            values4.append(stat.CA.eurlast30 ?? 0)
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
                
            chartDataSet.colors = [Yellow, Orange, uicolorFromHex(0x82C9F0),uicolorFromHex(0x82a9F0)]
                
                let chartData = BarChartData(dataSet: chartDataSet)
            self.chartView.data = chartData
                
            let xaxis = self.chartView.xAxis
            xaxis.valueFormatter = self.axisFormatDelegate
                xaxis.labelPosition = .bottom
        }


    }
    
    @IBAction func selectionChanged(_ sender: UISegmentedControl) {
        let app     = appSelection.titleForSegment(at: appSelection.selectedSegmentIndex)
        if app == "ALL" {
            updateUIAll()
        } else {
            updateUI()
        }
    }

    
    private func updateUI() {

      

        let range   = "all"
        let app     = "MB"
        let type    = "IMPR"

        
        let statsRef = TKDatabase.todo().reference(withPath: "stats")
        let startDate = range == "all" ? "2020-01-01" : Date().thirtyDaysAgoYMD
        let endDate = Date().todayYMD

        self.datas = [TKData]()
        
        statsRef.queryOrderedByKey().queryStarting(atValue: startDate).queryEnding(atValue: endDate).observeSingleEvent(of: .value) { (snap) in
            
           
                
            for snap in snap.children {
                if let snap = snap as? DataSnapshot {
                    if let stat:Stat = try!snap.decoded() {

                        
                        // create TKData for the graph depending on the selections
                        switch app {
                        case "MB":
                            switch type {
                            case "IMPR":
                                self.datas.append(TKData(dateString: snap.key, value: stat.MB.itc_impressionsTotal ?? 0))
                            case "WLM":
                                self.datas.append(TKData(dateString: snap.key, value: stat.MB.who_liked_me_vc_called ?? 0))
                            case "IAPP":
                                self.datas.append(TKData(dateString: snap.key, value: stat.MB.iapp ?? 0))
                            case "IAP":
                                self.datas.append(TKData(dateString: snap.key, value: stat.MB.iap ?? 0))
                            case "SALES":
                                self.datas.append(TKData(dateString: snap.key, value: stat.MB.itc_saleseur ?? 0))
                            case "EUR30":
                                self.datas.append(TKData(dateString: snap.key, value: stat.MB.eurlast30 ?? 0))
                            case "INST":
                                self.datas.append(TKData(dateString: snap.key, value: stat.MB.deviceids ?? 0))
                            case "PRF":
                                self.datas.append(TKData(dateString: snap.key, value: stat.MB.profile_created ?? 0))
                            case "FCMS":
                                self.datas.append(TKData(dateString: snap.key, value: stat.MB.fcm_success ?? 0))
                            case "DEL":
                                self.datas.append(TKData(dateString: snap.key, value: stat.MB.profile_deletions ?? 0))
                            default:
                                print ("error")
                            }
                        case "NB":
                            switch type {
                            case "IMPR":
                                self.datas.append(TKData(dateString: snap.key, value: stat.NB.itc_impressionsTotal ?? 0))
                            case "WLM":
                                self.datas.append(TKData(dateString: snap.key, value: stat.NB.who_liked_me_vc_called ?? 0))
                            case "IAPP":
                                self.datas.append(TKData(dateString: snap.key, value: stat.NB.iapp ?? 0))
                            case "IAP":
                                self.datas.append(TKData(dateString: snap.key, value: stat.NB.iap ?? 0))
                            case "SALES":
                                self.datas.append(TKData(dateString: snap.key, value: stat.NB.itc_saleseur ?? 0))
                            case "EUR30":
                                self.datas.append(TKData(dateString: snap.key, value: stat.NB.eurlast30 ?? 0))
                            case "INST":
                                self.datas.append(TKData(dateString: snap.key, value: stat.NB.deviceids ?? 0))
                            case "PRF":
                                self.datas.append(TKData(dateString: snap.key, value: stat.NB.profile_created ?? 0))
                            case "FCMS":
                                self.datas.append(TKData(dateString: snap.key, value: stat.NB.fcm_success ?? 0))
                            case "DEL":
                                self.datas.append(TKData(dateString: snap.key, value: stat.NB.profile_deletions ?? 0))
                                
                            default:
                                print ("type error")
                            }
                            
                        case "SW":
                            switch type {
                            case "IMPR":
                                self.datas.append(TKData(dateString: snap.key, value: stat.SW.itc_impressionsTotal ?? 0))
                            case "WLM":
                                self.datas.append(TKData(dateString: snap.key, value: stat.SW.who_liked_me_vc_called ?? 0))
                            case "IAPP":
                                self.datas.append(TKData(dateString: snap.key, value: stat.SW.iapp ?? 0))
                            case "IAP":
                                self.datas.append(TKData(dateString: snap.key, value: stat.SW.iap ?? 0))
                            case "SALES":
                                self.datas.append(TKData(dateString: snap.key, value: stat.SW.itc_saleseur ?? 0))
                            case "EUR30":
                                self.datas.append(TKData(dateString: snap.key, value: stat.SW.eurlast30 ?? 0))
                            case "INST":
                                self.datas.append(TKData(dateString: snap.key, value: stat.SW.deviceids ?? 0))
                            case "PRF":
                                self.datas.append(TKData(dateString: snap.key, value: stat.SW.profile_created ?? 0))
                            case "FCMS":
                                self.datas.append(TKData(dateString: snap.key, value: stat.SW.fcm_success ?? 0))
                            case "DEL":
                                self.datas.append(TKData(dateString: snap.key, value: stat.SW.profile_deletions ?? 0))
                            default:
                                print ("type error")
                            }
                            
                        case "CA":
                            switch type {
                            case "IMPR":
                                self.datas.append(TKData(dateString: snap.key, value: stat.CA.itc_impressionsTotal ?? 0))
                            case "WLM":
                                self.datas.append(TKData(dateString: snap.key, value: stat.CA.who_liked_me_vc_called ?? 0))
                            case "IAPP":
                                self.datas.append(TKData(dateString: snap.key, value: stat.CA.iapp ?? 0))
                            case "IAP":
                                self.datas.append(TKData(dateString: snap.key, value: stat.CA.iap ?? 0))
                            case "SALES":
                                self.datas.append(TKData(dateString: snap.key, value: stat.CA.itc_saleseur ?? 0))
                            case "EUR30":
                                self.datas.append(TKData(dateString: snap.key, value: stat.CA.eurlast30 ?? 0))
                            case "INST":
                                self.datas.append(TKData(dateString: snap.key, value: stat.CA.deviceids ?? 0))
                            case "PRF":
                                self.datas.append(TKData(dateString: snap.key, value: stat.CA.profile_created ?? 0))
                            case "FCMS":
                                self.datas.append(TKData(dateString: snap.key, value: stat.CA.fcm_success ?? 0))
                            case "DEL":
                                self.datas.append(TKData(dateString: snap.key, value: stat.CA.profile_deletions ?? 0))

                            default:
                                print ("type error")
                            }
                        default:
                            print("error")
                        }
                    }
                }
            }
        }
    }

    @IBAction func refreshData(_ sender: Any) {
        saveDataToUserDefaults()
    }
    @IBOutlet weak var cacheLabel: UILabel!
    @IBAction func loadData() {
        getDataFromUserDefaults()
        updateUI()
        cacheLabel.text = UserDefaults.standard.string(forKey: "cacheAge")
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// get all available Data from database and save them to NSUserDefaults
    
    private func saveDataToUserDefaults() {

       
        
        let statsRef = TKDatabase.todo().reference(withPath: "stats")
        let startDate = "2019-12-01"
        let endDate = Date().todayYMD
        
        statsRef.queryOrderedByKey().queryStarting(atValue: startDate).queryEnding(atValue: endDate).observeSingleEvent(of: .value) { (snap) in
            
           
            self.datas.removeAll()
            for snap in snap.children {
                 if let snap = snap as? DataSnapshot {
                    if var stat:TKData = try!snap.decoded() {
                        stat.dateString = snap.key
                        self.datas.append(stat)
                    }
                }
            }

            var array = [[String:Any]]()
            for val in self.datas {
                array.append(val.dictionary!)
            }
            UserDefaults.standard.set(array, forKey: "test")
        }
        UserDefaults.standard.set(Date().todayYMD, forKey: "cacheAge")
    }
    
    /// read data from userdefaults and store them locally
    
    private func getDataFromUserDefaults() {

        let x = UserDefaults.standard.value(forKey: "test")
        guard let vals = x as? [[String:AnyObject]] else { return }
        var statsNew = [TKData]()
        for val in vals {
        do {
                let jsonData = try JSONSerialization.data(withJSONObject: val
                   , options: [])
                let decoder =  JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let object = try decoder.decode(TKData.self, from: jsonData)
                statsNew.append(object)

            } catch {
              //  print("Error parsing \(Type.self). Details follow:")
                print("Result: Returning nil")
            }
        }
        self.datas = (statsNew)
    }
    
    private func updateChartWithData() {
        if chartView == nil {
            return
        }
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<datas.count {

            let dataEntry = BarChartDataEntry(x: Double(i), y: datas[i].value)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: nil)
        chartDataSet.colors = [uicolorFromHex(0x82C9F0)]
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        let xaxis = chartView.xAxis
        xaxis.valueFormatter = axisFormatDelegate
        xaxis.labelPosition = .bottom
    }
    
    private func getData(complete: (_ datas:[TKData]) -> Void) {
        
        let datas = [
            TKData(dateString: "2019-12-11", value: 23.4),
            TKData(dateString: "2011-01-02", value: 33.4),
            TKData(dateString: "2011-01-03", value: 43.4),
            TKData(dateString: "2011-01-04", value: 33.4),
            TKData(dateString: "2011-01-05", value: 23.4),
            TKData(dateString: "2011-01-06", value: 13.4),
            
        ]
        complete(datas)
    }
    
    // MARK: - HELPER FUNCTIONS
    
    private func getTitelFor(key:String) -> String {
        switch key {
        case "itc_impressionsTotal":return "Impressions"
        case "itc_units": return "Units"
        case "itc_iaps": return "IAPs"
        case "iapp":return "IAPP"
        case "sales":return "Sales"
        case "salestotal": return "Sales Total"
        default: return "err"
        }
    }
    
    private func configureChart() {
        /*
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawZeroLineEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawZeroLineEnabled = false
        chartView.leftAxis.drawTopYLabelEntryEnabled = true
        chartView.leftAxis.drawBottomYLabelEntryEnabled = false
        */
        // zeigt die Values an
        chartView.barData?.dataSets.first?.drawValuesEnabled = true
        chartView.barData?.dataSets.first?.valueFormatter = LargeValueFormatter()

        chartView.animate(yAxisDuration: 3)
        chartView.xAxis.labelCount = 20
        

        // delegate
        chartView.delegate = self
    }
}


extension ChartViewController: IAxisValueFormatter {

    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let dateStrig = datas?[Int(value)].dateString else { return "" }
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let date = df.date(from: dateStrig)
        df.dateFormat = "dd/MM"
        if let date = date {
            let weekday = Calendar.current.component(.weekday, from: date)
            let weekdayShort = df.shortWeekdaySymbols[weekday - 1]
            let dateString = df.string(from: date)
            let string = "\(weekdayShort)\n\(dateString)"
            return string
        } else {
            return "err"
        }
    }
 
}
 

struct TKData:Codable {
    var dateString: String
    var value:Double
}

func uicolorFromHex(_ rgbValue:UInt32) -> UIColor {
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0

    return UIColor(red:red, green:green, blue:blue, alpha:1.0)
}


// Show popup with detail value when klicking on value

extension ChartViewController:ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let marker:BalloonMarker = BalloonMarker(color: UIColor.black, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75.0, height: 35.0)
        chartView.marker = marker
    }
}


struct StatData:Codable {
    var app_exception:Double?
    var itc_crashes:Double?
    var itc_iaps:Double?
    var itc_impressionsTotal:Double?
    var iap:Double?
    var iapp:Double?
    var itc_saleseur:Double?
    var fcm_invocations:Double?
    var fcm_success:Double?
    var fcmtoken_registered:Double?
    var profile_deletions:Double?
    var deviceids:Double?
    var deletionratio:Double?
    var uid_created:Double?
    var uidratio:Double?
    var profile_created:Double?
    var profileratio:Double?
    var iappratio:Double?
    var eurlast30:Double?
    var currentVersions:CurrentVersions?
    var who_liked_me_vc_called:Double?
}
struct Stat:Codable {
    var dateString:String?
    var CA:StatData
    var MB:StatData
    var NB:StatData
    var SW:StatData
}
struct CurrentVersions:Codable {
    var rel_status:String?
    var rel_version:String?
    var pre_status:String?
}
