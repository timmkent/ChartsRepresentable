//
//  AppDelegate.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 17/06/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
               
        FirebaseConfig.configureMyBoyDatabase()
        FirebaseConfig.configureNextBoyDatabase()
        FirebaseConfig.configureDashboardDatabase()
        FirebaseConfig.configureSwindaDatabase()
        FirebaseConfig.configureCatschaDatabase()
        FirebaseConfig.configureTodoDatabase()
        FirebaseConfig.configureChartsDatabase()
        
        // Copy EVERYTHING to charts
        /*
        TKDatabase.todo().reference().child("stats").observeSingleEvent(of: .value) { (snap) in
            for snap in snap.children {
                if let snap = snap as? DataSnapshot {
                    let dateString = snap.key
         
                    if let stat:StatConversion = try!snap.decoded() {

                        func writeEntry(app:StatData?, name:String) {
                            if app == nil { return }
                            let ref = TKDatabase.charts().reference().child("charts").child(name)
                            ref.child("eurlast30").child(dateString).updateChildValues(["value":app!.eurlast30])
                            
                            
                            ref.child("itc_crashes").child(dateString).updateChildValues(["value":app!.itc_crashes])
                            ref.child("itc_iaps").child(dateString).updateChildValues(["value":app!.itc_iaps])
                            ref.child("itc_impressionsTotal").child(dateString).updateChildValues(["value":app!.itc_impressionsTotal])
                            ref.child("iap").child(dateString).updateChildValues(["value":app!.iap])
                            ref.child("iapp").child(dateString).updateChildValues(["value":app!.iapp])
                            ref.child("saleseur").child(dateString).updateChildValues(["value":app!.saleseur])
                            ref.child("fcm_invocations").child(dateString).updateChildValues(["value":app!.fcm_invocations])
                            ref.child("fcm_success").child(dateString).updateChildValues(["value":app!.fcm_success])
                            ref.child("fcmtoken_registered").child(dateString).updateChildValues(["value":app!.fcmtoken_registered])
                            ref.child("profile_deletions").child(dateString).updateChildValues(["value":app!.profile_deletions])
                            ref.child("deviceids").child(dateString).updateChildValues(["value":app!.deviceids])
                            ref.child("deletionratio").child(dateString).updateChildValues(["value":app!.deletionratio])
                            ref.child("uid_created").child(dateString).updateChildValues(["value":app!.uid_created])
                            ref.child("uidratio").child(dateString).updateChildValues(["value":app!.uidratio])
                            ref.child("profile_created").child(dateString).updateChildValues(["value":app!.profile_created])
                            ref.child("profileratio").child(dateString).updateChildValues(["value":app!.profileratio])
                            ref.child("iappratio").child(dateString).updateChildValues(["value":app!.iappratio])
                            ref.child("eurlast30").child(dateString).updateChildValues(["value":app!.eurlast30])
                            
                        }
                        
                        writeEntry(app: stat.MB, name:"MB")
                        writeEntry(app: stat.NB, name:"NB")
                        writeEntry(app: stat.SW, name:"SW")
                        writeEntry(app: stat.CA, name:"CA")
          

                        
                        
                    }

                }
            }
        }
        */
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

