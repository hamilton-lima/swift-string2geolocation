//
//  ViewController.swift
//  StringToGeoLocation
//
//  Created by Hamilton Lima on 2017-08-19.
//  Copyright © 2017 Hamilton Lima. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class ViewController: UIViewController {

    
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func seeOnMapTouchDown(_ sender: Any) {
        print("seeOnMap", addressText.text ?? "" )
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(addressText.text!,completionHandler: processAdressResponse)
        
    }
    
    func processAdressResponse(placemarks:[CLPlacemark]?, error: Error?){

        print("processAdressResponse", placemarks ?? "[no place marks]", error ?? "no error" )
        
        if (error == nil && placemarks != nil ) {
            if( (placemarks?.count)! > 0 ) {

                let location = (placemarks?.first?.location)!
                
                let annotation = MapPin(
                    coordinate: location.coordinate,
                    title: "Home",
                    subtitle: addressText.text!)
          
                mapView.showAnnotations([annotation], animated: true)
                mapView.selectAnnotation(annotation, animated: true)
            }
        }
    }


}

