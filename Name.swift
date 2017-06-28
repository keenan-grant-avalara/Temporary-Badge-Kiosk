//
//  Name.swift
//  KioskProjB
//
//  Created by Keenan Grant on 6/22/17.
//  Copyright © 2017 Keenan Grant. All rights reserved.
//

import UIKit
import os.log

class Name: NSObject, NSCoding {
    
    var namer: String
    var badge: String
    
    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("names")
    
    struct PropertyKey {
        static let name = "name"
        static let badge = "badge"
    }
    
    init?(namer: String, badge: String) {
        
        guard !namer.isEmpty
        else {
            return nil
        }
        guard !badge.isEmpty
            else {
                return nil
        }
        
        self.namer = namer
        self.badge = badge
    }
        //NSCoding
        func encode(with aCoder: NSCoder) {
            aCoder.encode(namer, forKey: PropertyKey.name)
            aCoder.encode(badge, forKey: PropertyKey.badge)
        }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for chosen cell", log: OSLog.default, type: .debug)
            return nil
        }
        let badge = aDecoder.decodeObject(forKey: PropertyKey.badge)
        
        self.init(namer: name, badge: badge as! String)
    }
}

