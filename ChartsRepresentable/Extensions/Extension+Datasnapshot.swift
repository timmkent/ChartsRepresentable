//
//  Extension+Datasnapshot.swift
//  myBoy
//
//  Created by Marc Felden on 15/08/2019.
//  Copyright © 2019 madeTK.com. All rights reserved.
//

// We write also SECONDS since. Never milli (becase we always did so)
import FirebaseDatabase

extension DataSnapshot {

    // Diese Funktion kommt mit jedem Object klar, solange es nur decodable ist.
    func decoded<Type:Decodable>() throws -> Type? {

        // Also gut, we koennen ihm sagen wie er DECODEN soll:

        guard let dict = self.value as? [String:AnyObject] else { print("Error: Object not parsable.")
            print("Dict: \(self)")
            return nil }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict
                , options: [])
            let decoder =  JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let object = try decoder.decode(Type.self, from: jsonData)
            return object
        } catch {
            print("Error parsing \(Type.self). Details follow:")
            print("Dict: \(dict)")
            print("Error: \(error)")
            print("Result: Returning nil")
            return nil
        }
    }
    
    func sizeInKB() -> Int {
        return Int(String(describing: self.value).count / 1024)
    }
    func sizeInMB() -> String {
        return "\(Int(String(describing: self.value).count / 1024 / 1024))MB"
    }
}
