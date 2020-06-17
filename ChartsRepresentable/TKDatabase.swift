//
//  FirebaseConfig.swift
//  BigNumber
//
//  Created by Marc Felden on 04.01.19.
//  Copyright © 2019 madeTK.com. All rights reserved.
//

import Firebase
import FirebaseDatabase
import FirebaseStorage


class FirebaseConfig {
    
    class func configureMyBoyDatabase() {
        // Initialize nextBoy also, so in BigNumber koennen wir darauf zugreifen.
        
        let options = FirebaseOptions(googleAppID: "1:355155790549:ios:d9b72bc1ce62ea2b", gcmSenderID: "355155790549")
        options.apiKey = "AIzaSyBcgtibPpuNxIqTsEFxuAKB2OX163d3F3w"
        options.googleAppID = "1:355155790549:ios:d9b72bc1ce62ea2b"
        options.databaseURL = "https://myboy-f2807.firebaseio.com"
        FirebaseApp.configure(name: "myBoy", options: options)
    }
    
    class func configureNextBoyDatabase() {
        // Initialize nextBoy also, so in BigNumber koennen wir darauf zugreifen.
        
        let options = FirebaseOptions(googleAppID: "1:441002393476:ios:442813749dccf0d1", gcmSenderID: "441002393476")
        options.apiKey = "AIzaSyBMeUM-7PxKt1bdoV_vxsYc-VpFyS3bbNo"
        options.googleAppID = "1:441002393476:ios:442813749dccf0d1"
        options.databaseURL = "https://nextboy-f45b3.firebaseio.com"
        FirebaseApp.configure(name: "nextBoy", options: options)
    }
    
    class func configureTodoDatabase() {
        // Initialize nextBoy also, so in BigNumber koennen wir darauf zugreifen.
        
        let options = FirebaseOptions(googleAppID: "1:1081892848491:ios:2aa51c0f98eca266b8c22e", gcmSenderID: "1081892848491")
        options.apiKey = "AIzaSyATW-Ir8xFbGRCoTx3DtC837w9aAsKLc88"
        options.googleAppID = "1:1081892848491:ios:2aa51c0f98eca266b8c22e"
        options.databaseURL = "https://todo-test-558b5.firebaseio.com"
        FirebaseApp.configure(name: "todo", options: options)
    }
    
    class func configureDashboardDatabase() {

        let options = FirebaseOptions(googleAppID: "1:529172679885:ios:81738e5d90e76d12", gcmSenderID: "529172679885")
        options.apiKey = "AIzaSyCTsRRhi9KHdIQBR4WdHhJsOJEWc2a_zes"
        options.googleAppID = "1:529172679885:ios:81738e5d90e76d12"
        options.databaseURL = "https://dashboard-de8e7.firebaseio.com"
        FirebaseApp.configure(name: "dashboard", options: options)
    }

    class func configureSwindaDatabase() {
        
        let options = FirebaseOptions(googleAppID: "1:891816629373:ios:19013ecab9c8dbb3564d14", gcmSenderID: "891816629373")
        options.apiKey = "AIzaSyAYiftY_nkqSBy0hFj49oHJlT34uAOtJoI"
        options.googleAppID = "1:891816629373:ios:19013ecab9c8dbb3564d14"
        options.databaseURL = "https://swinda-f360d.firebaseio.com"
        options.storageBucket = "swinda-f360d.appspot.com"
        FirebaseApp.configure(name: "swinda", options: options)
    }
    class func configureCatschaDatabase() {
        
        let options = FirebaseOptions(googleAppID: "1:116994546014:ios:e72f2ce8c96f9598", gcmSenderID: "116994546014")
        options.apiKey = "AIzaSyBH0HC3pnzuOD4feXs2GUXlbKgNEBfdJ5Q"
        options.googleAppID = "1:116994546014:ios:e72f2ce8c96f9598"
        options.databaseURL = "https://catscha-64e2b.firebaseio.com"
        options.storageBucket = "catscha-64e2b.appspot.com"
        FirebaseApp.configure(name: "catscha", options: options)
    }
}

class TKDatabase {
    
    class func nextBoy() -> Database {
        return Database.database(app: FirebaseApp.app(name: "nextBoy")!)
        
    }
    
    class func myBoy() -> Database {
        return Database.database(app: FirebaseApp.app(name: "myBoy")!)
    }
    
    class func dashboard() -> Database {
        return Database.database(app: FirebaseApp.app(name: "dashboard")!)
    }
    
    class func swinda() -> Database {
        return Database.database(app: FirebaseApp.app(name: "swinda")!)
    }
    class func catscha() -> Database {
        return Database.database(app: FirebaseApp.app(name: "catscha")!)
    }
    class func todo() -> Database {
        return Database.database(app: FirebaseApp.app(name: "todo")!)
    }
    
    class func autolikeEngine02Queue() -> DatabaseReference {
        TKDatabase.dashboard().reference().child("likesengine").child("queue")
    }
}

class TKStorage {
    
    class func nextBoy() -> Storage {
        return Storage.storage(app: FirebaseApp.app(name: "nextBoy")!)
        
    }
    
    class func myBoy() -> Storage {
        return Storage.storage(app: FirebaseApp.app(name: "myBoy")!)
    }
    
    class func dashboard() -> Storage {
        return Storage.storage(app: FirebaseApp.app(name: "dashboard")!)
    }
    
    class func swinda() -> Storage {
        return Storage.storage(app: FirebaseApp.app(name: "swinda")!)
    }
    class func catscha() -> Storage {
        return Storage.storage(app: FirebaseApp.app(name: "catscha")!)
    }
    
}
