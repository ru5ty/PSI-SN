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
    var regions: [Region] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.cameraToCenter(coordinate: CLLocationCoordinate2D(latitude: 1.290270, longitude: 103.851959), zoom: 10.7)
        
        Services.sharedInstance.getPollutantData(params: nil) { (results, success) in
            if success {
                self.regions = results as! [Region]
                self.composePin(regions: self.regions)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as! DetailViewController
        detail.selectedRegion = sender as! Region
    }
    
    func composePin(regions: [Region]) {
        var index = 0
        for region in regions {
            if region.name != "national" {
                let pin = self.makePin(region: region)
                if region.name == "central" {
                    self.cameraToCenter(coordinate: region.coordinate, zoom: 10.7)
                }
                pin.userData = index
                pin.map = mapContainerView
                index+=1
            }
        }
    }
    
    func makePin(region: Region) -> GMSMarker {
        let marker = GMSMarker(position: region.coordinate)
        marker.snippet = region.name.uppercased()
        marker.title = "singapore".uppercased()
        return marker
    }
    
    func cameraToCenter(coordinate: CLLocationCoordinate2D, zoom: Float) {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
        mapContainerView.camera = camera
    }
    
    func gotoDetail(region: Region){
        self.performSegue(withIdentifier: "detailSegue", sender: region)
    }
    
    func getSelectedRegion(index: Int) -> Region{
        return self.regions[index]
    }
}

extension ViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let region = self.getSelectedRegion(index: marker.userData as! Int)
        self.gotoDetail(region: region)
    }
}

