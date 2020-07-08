//
//  MenuView.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 03/07/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import SwiftUI


struct MenuView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                
                HStack {
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: Impressions(appshort: "MB", key: "itc_impressionsTotal"), label: {Text("Impressions MB").foregroundColor(.black)})
                    )
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: Impressions(appshort: "NB", key: "itc_impressionsTotal"), label: {Text("Impressions NB").foregroundColor(.black)})
                    )
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: Impressions(appshort: "CA", key: "itc_impressionsTotal"), label: {Text("Impressions CA").foregroundColor(.black)})
                    )
                }
                
                HStack {
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: Units(appshort: "MB", key: "itc_units"), label: {Text("Units MB").foregroundColor(.black)})
                    )
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: Units(appshort: "NB", key: "itc_units"), label: {Text("Units NB").foregroundColor(.black)})
                    )
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: Units(appshort: "CA", key: "itc_units"), label: {Text("Units CA").foregroundColor(.black)})
                    )
                }
                
                
                HStack {
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: Rankings(app: "MB"), label: {Text("Rankings MB").foregroundColor(.black)})
                    )
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: Rankings(app: "NB"), label: {Text("Rankings NB").foregroundColor(.black)})
                    )
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: Rankings(app: "CA"), label: {Text("Rankings CA").foregroundColor(.black)})
                    )
                }
                
                HStack {
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: RatingViewPerApp(app: "MB", key: "itc_ratingCount"), label: {Text("Ratings MB").foregroundColor(.black)})
                    )
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: RatingViewPerApp(app: "NB", key: "itc_ratingCount"), label: {Text("Ratings NB").foregroundColor(.black)})
                    )
                    Rectangle().foregroundColor(Color.green.opacity(0.2)).frame(width: 200, height: 200).overlay(
                        NavigationLink(destination: RatingViewPerApp(app: "CA", key: "itc_ratingCount"), label: {Text("Ratings CA").foregroundColor(.black)})
                    )
                }
            }


        }.navigationViewStyle(StackNavigationViewStyle())

    }
}
