//
//  ViewController.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 29/03/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit
import GoogleMaps

let max: CGFloat = 122.16
let min: CGFloat = 25.16

class ViewController: UIViewController {
    @IBOutlet weak var mapContainerView: GMSMapView!
    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var constTopFilterView: NSLayoutConstraint!
    var regions: [Region] = []
    var dateFilter: Date = Date()
    var timeFilter: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.cameraToCenter(coordinate: CLLocationCoordinate2D(latitude: 1.290270, longitude: 103.851959), zoom: 10.7)
        
        self.getPollutions(parameter: nil)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        self.filterContainerView.isUserInteractionEnabled = true
        self.filterContainerView.addGestureRecognizer(panGesture)
        
        self.dropButton.imageView?.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as! DetailViewController
        detail.selectedRegion = sender as! Region
    }
    
//    MARK: Customs
    /**
     Call Pollutant API
     - Parameter parameter: date / time filter
     */
    func getPollutions(parameter: [String : Any]?) {
        HUD.sharedInstance.showHUD()
        Services.sharedInstance.getPollutantData(params: parameter) { (results, success) in
            if success {
                self.regions = results as! [Region]
                self.composePin(regions: self.regions)
                HUD.sharedInstance.setComplete()
            } else {
                HUD.sharedInstance.dismissWithMessage(msg: "Failed")
            }
        }
    }
    
    /**
     Compose pin marker into maps
     - Parameter regions: array of region, result from API
     */
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
            }
            index+=1
        }
    }
    
    /**
     Create google maps pin marker
     - Parameter region: selected region from API
     */
    func makePin(region: Region) -> GMSMarker {
        let marker = GMSMarker(position: region.coordinate)
        marker.snippet = region.name.uppercased()
        marker.title = "singapore".uppercased()
        return marker
    }
    
    /**
     Zoom & centering maps
     - Parameter coordinate: coordinate to center
     - Parameter zoom: number of zooming
     */
    func cameraToCenter(coordinate: CLLocationCoordinate2D, zoom: Float) {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
        mapContainerView.camera = camera
    }
    
    /**
     Push to reading page
     - Parameter region: selected region from API
     */
    func gotoDetail(region: Region){
        self.performSegue(withIdentifier: "detailSegue", sender: region)
    }
    
    /**
     Get selected region when tap pin marker
     - Parameter index: index of selected region
     */
    func getSelectedRegion(index: Int) -> Region{
        return self.regions[index]
    }
    
    /**
     Dragable filter view
     - Parameter sender: pan gesture
     */
    @objc func draggedView(_ sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        var top: CGFloat = self.filterContainerView.center.y + translation.y
        if sender.velocity(in: self.filterContainerView).y > 0 {
            top = top > max ? max : top
        } else {
            top = top < min ? min : top
        }
        self.setFilterCenter(center: CGPoint(x: self.filterContainerView.center.x, y: top))
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    /**
     Set center of filter view
     - Parameter center: center of point
     */
    func setFilterCenter(center: CGPoint!){
        self.filterContainerView.center = center
        self.rotateButton(angle: CGFloat(center.y==min ? 0 : Double.pi))
        self.constTopFilterView.constant = self.filterContainerView.bounds.origin.y
        
    }
    
    /**
     Rotate filter view indicator
     - Parameter angle: rotation degree
     */
    func rotateButton(angle: CGFloat){
        self.dropButton.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    /**
     Refrest Pollutant API with filter
     */
    func refreshData(){
        var params: [String : Any] = [:]
        if !(self.dateTextField.text?.isEmpty)! {
            params["date"] = DateCustomization().dateToString(date: self.dateFilter, format: "yyyy-MM-dd")
        }
        if !(self.timeTextField.text?.isEmpty)! {
            params["time"] = DateCustomization().dateToString(date: self.timeFilter, format: "yyyy-MM-dd'T'HH:mm:ss")
        }
        self.getPollutions(parameter: params)
    }
    
//    MARK: Actions
    @IBAction func dropAction(_ sender: Any) {
        var top: CGFloat = 0.0
        if self.filterContainerView.center.y >= max {
            top = min
        } else {
            top = max
        }
        self.setFilterCenter(center: CGPoint(x: self.filterContainerView.center.x, y: top))
    }
}

extension ViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let region = self.getSelectedRegion(index: marker.userData as! Int)
        let view = Bundle.main.loadNibNamed("MapMarker", owner: self, options: nil)?.first as! MapMarker
        view.topLabel.text = "singapore".uppercased()
        view.bottomLabel.text = region.name.uppercased()
        return view
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let region = self.getSelectedRegion(index: marker.userData as! Int)
        self.gotoDetail(region: region)
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        self.view.endEditing(true)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.view.endEditing(true)
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var customInput: CustomInputView!
        if textField == self.dateTextField {
            customInput = CustomInputView.instanceFromNIB(inputType: .Date)
            textField.inputView = customInput
        } else if textField == self.timeTextField {
            customInput = CustomInputView.instanceFromNIB(inputType: .Time)
            textField.inputView = customInput
        }
        customInput.doneTapped = { (sender) in
            var str: String = ""
            if customInput.type == .Date {
                self.dateFilter = sender as! Date
                str = DateCustomization().dateToString(date: self.dateFilter, format: "dd MMMM yyyy")
            } else {
                self.timeFilter = sender as! Date
                str = DateCustomization().dateToString(date: self.timeFilter, format: "HH:mm")
            }
            textField.text = str
            textField.endEditing(true)
            self.refreshData()
        }
        customInput.cancelTapped = { (sender) in
            textField.endEditing(true)
            self.refreshData()
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        self.refreshData()
        return true
    }
}
