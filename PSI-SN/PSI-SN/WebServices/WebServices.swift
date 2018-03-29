//
//  WebServices.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 29/03/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

struct EndPoint {
    static let baseURL = "https://api.data.gov.sg/v1"
    static let pollutant = "/environment/psi"
}

class Services: NSObject {
    
    /**
        Shared Instance of API Services
     */
    static let sharedInstance = Services()
    
    func getPollutantData(params: [String: Any]?, completion:@escaping (_ data : Any, _ isSuccess : Bool) -> Void) {
        
    }
}
