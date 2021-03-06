//
//  Stat.swift
//  ChartsRepresentable
//
//  Created by Marc Felden on 20/06/2020.
//  Copyright © 2020 Marc Felden. All rights reserved.
//

import Foundation



struct StatData:Codable {
    var itc_crashes:Double?
    var itc_iaps:Double?
    var itc_impressionsTotal:Double?
    
    // new
    var itc_pageViewCount:Double?
    var itc_ratingCount:Double?
    var itc_ratingFiveCount:Double?
    var itc_ratingFourCount:Double?
    var itc_ratingOneCount:Double?
    var itc_ratingThreeCount:Double?
    var itc_ratingTwoCount:Double?
    var itc_sales:Double?
    var itc_saleseur:Double?
    var itc_units:Double?
    
    var iap:Double?
    var iapp:Double?
    var saleseur:Double?
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
}
struct Stat:Codable {
    var CA:StatData
    var MB:StatData
    var NB:StatData
    var SW:StatData
}

struct StatConversion:Codable {
    var CA:StatData?
    var MB:StatData?
    var NB:StatData?
    var SW:StatData?
}
