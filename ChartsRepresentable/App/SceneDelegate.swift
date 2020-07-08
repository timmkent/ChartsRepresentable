//
//  SceneDelegate.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 17/06/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

       // let contentView = CombinedChartWrapper(startDate: "2020-01-01", appshort: "MB", key: "test")

     //    let contentView = BarChartWrapper(startDate: "2020-01-01", appshort: "MB", key: "test")
        
        let contentView = MenuView()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}


struct RatingsMenu:View {
    let apps = ["MB","NB","SW","CA","WE"]
    let keys = ["itc_ratingCount","itc_ratingFiveCount","itc_ratingOneCount"]
    var body: some View {
        NavigationView {
            List {
                ForEach(apps, id:\.self) { app in
                    ForEach(self.keys, id:\.self) { key in
                        NavigationLink("\(app), \(key)", destination: RatingViewPerApp(app: app, key:key))
                    }
                    
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
