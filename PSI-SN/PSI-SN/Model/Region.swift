//
//  Region.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 30/03/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import Tailor
import CoreLocation

class Region: Mappable {
    
    var name : String!
    var coordinate : CLLocationCoordinate2D!
    var o3SubIndex : Int!
    var pm10TwentyFour : Int!
    var pm10SubIndex : Int!
    var coSubIndex : Int!
    var pm25TwentyFour : Int!
    var so2SubIndex : Int!
    var coEight : Double!
    var no2One : Int!
    var so2TwentyFour : Int!
    var pm25SubIndex : Int!
    var psiTwentyFour : Int!
    var o3Eight : Int!
    
    required init(_ map: [String : Any]) {
        name <- map.property("name")
        coordinate <- map.transform("label_location", transformer: { (value: [String : Double]) -> CLLocationCoordinate2D? in
            return CLLocationCoordinate2D(latitude: value["latitude"]!, longitude: value["longitude"]!)
        })
    }
    
    func initReading(_ map: [String : Any]) {
        for key in map.keys {
            switch key{
            case "o3_sub_index":
                o3SubIndex <- map.transform(key, transformer: { (value: [String : Int]) -> Int? in
                    return value[name]
                })
                break
            case "pm10_twenty_four_hourly":
                pm10TwentyFour <- map.transform(key, transformer: { (value: [String : Int]) -> Int? in
                    return value[name]
                })
                break
            case "pm10_sub_index":
                pm10SubIndex <- map.transform(key, transformer: { (value: [String : Int]) -> Int? in
                    return value[name]
                })
                break
            case "co_sub_index":
                coSubIndex <- map.transform(key, transformer: { (value: [String : Int]) -> Int? in
                    return value[name]
                })
                break
            case "pm25_twenty_four_hourly":
                pm25TwentyFour <- map.transform(key, transformer: { (value: [String : Int]) -> Int? in
                    return value[name]
                })
                break
            case "so2_sub_index":
                so2SubIndex <- map.transform(key, transformer: { (value: [String : Int]) -> Int? in
                    return value[name]
                })
                break
            case "co_eight_hour_max":
                coEight <- map.transform(key, transformer: { (value: [String : Double]) -> Double? in
                    return value[name]
                })
                break
            case "no2_one_hour_max":
                no2One <- map.transform(key, transformer: { (value: [String : Int]) -> Int? in
                    return value[name]
                })
                break
            case "so2_twenty_four_hourly":
                so2TwentyFour <- map.transform(key, transformer: { (value: [String : Int]) -> Int? in
                    return value[name]
                })
                break
            case "pm25_sub_index":
                pm25SubIndex <- map.transform(key, transformer: { (value: [String : Int]) -> Int? in
                    return value[name]
                })
                break
            case "psi_twenty_four_hourly":
                psiTwentyFour <- map.transform(key, transformer: { (value: [String : Int]) -> Int? in
                    return value[name]
                })
                break
            case "o3_eight_hour_max":
                o3Eight <- map.transform(key, transformer: { (value: [String : Int]) -> Int? in
                    return value[name]
                })
                break
            default:
                break
            }
        }
    }
}
