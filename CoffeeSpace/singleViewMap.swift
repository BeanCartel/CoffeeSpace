//
//  singleViewMap.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 4/19/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import MapKit
import CoreLocation

class singleViewMap: UIViewController, MKMapViewDelegate {
    
    var name: String = ""
    var lat: Double = 0
    var long: Double = 0
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var shop: ShopsWithYelp! {
        didSet {
            self.name = shop.name!
            self.lat = (shop.coordinates!["latitude"] as? Double)!
            self.long = (shop.coordinates!["longitude"] as? Double)!
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let coordinates = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
        // set the region to display, this also sets a correct zoom level
        // set starting center location in San Francisco
        
        let centerLocation = CLLocation(latitude: self.lat, longitude: self.long)
        addAnnotationAtCoordinate(coordinates)
        goToLocation(centerLocation)
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = self.name
        
        mapView.addAnnotation(annotation)
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        let appleMapsURL = "http://maps.apple.com/?q=\(view.annotation!.coordinate.latitude),\(view.annotation!.coordinate.longitude)"
        UIApplication.sharedApplication().openURL(NSURL(string: appleMapsURL)!)
    }
    
    
}
