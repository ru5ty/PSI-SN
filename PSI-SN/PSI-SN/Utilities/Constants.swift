//
//  Constants.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 29/03/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

let kMAPS_API = "AIzaSyDCZpGVZ78JqfqrSlJGeCC5Mn7lZbXW8EE"

struct Constants {
    
    /**
     Struct usable enumeration
     */
    struct Enumeration {
        /**
         Input picker options.
         ````
         case Date
         case Time
         case Other
         ````
         */
        enum InputType : Int, EnumCollection {
            /// Input picker with Date type
            case Date = 1
            /// Input picker with Time type
            case Time = 2
            /// Input picker with Custom type
            case Other = 3
        }
    }
}
