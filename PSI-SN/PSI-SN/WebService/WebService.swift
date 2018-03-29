//
//  WebServices.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 29/03/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import Alamofire

struct EndPoint {
    static let baseURL = "https://api.data.gov.sg/v1"
    static let pollutant = "/environment/psi"
}

class Services: NSObject {
    
    /**
        Shared Instance of API Services
     */
    static let sharedInstance = Services()
    
    /**
        Get All Pollutant Data
        - Parameter params: dictionary of parameters
        - Completion data: result object from API
        - Completion isSuccess: return API response code
     */
    func getPollutantData(params: [String: Any]?, completion:@escaping (_ data : Any, _ isSuccess : Bool) -> Void) {
        Alamofire.request(EndPoint.pollutant, method: .get, parameters: params).validate().responseJSON { (response) in
            if response.result.isSuccess {
                
            }
        }
        
    }
}
