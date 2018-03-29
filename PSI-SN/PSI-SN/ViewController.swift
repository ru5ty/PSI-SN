//
//  ViewController.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 29/03/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    @IBOutlet weak var mapContainerView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let camera = GMSCameraPosition.camera(withLatitude: 1.290270, longitude: 103.851959, zoom: 11.0)
        mapContainerView.camera = camera
        
        Services.sharedInstance.getPollutantData(params: nil) { (results, success) in
            if success {
                self.composePin(regions: results as! [Region])
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func composePin(regions: [Region]) {
        for region in regions {
            if region.name != "national" {
                let pin = self.makePin(region: region)
                pin.map = mapContainerView
            }
        }
    }
    
    func makePin(region: Region) -> GMSMarker {
        let marker = GMSMarker(position: region.coordinate)
        marker.snippet = region.name.uppercased()
        marker.title = "singapore".uppercased()
        return marker
    }
}

