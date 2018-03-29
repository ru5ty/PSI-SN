//
//  DataManager.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 29/03/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    static let sharedInstance = DataManager()
    
    func composePollutantData(data: [String : Any]) -> [Region]! {
        var regions = [Region]()
        for region : [String : Any] in data["region_metadata"] as! [[String : Any]] {
            let newRegion = Region.init(region)
            let firstItem = (data["items"] as! [[String : Any]]).first
            newRegion.initReading(firstItem!["readings"] as! [String : Any])
            regions.append(newRegion)
        }
        return regions
    }
}
