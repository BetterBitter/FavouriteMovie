//
//  CinemaNearMeViewController.swift
//  CinemaApp
//
//  Created by Riko Pratama Laimena on 9/27/17.
//  Copyright © 2017 Riko Pratama Laimena. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CinemaNearMeViewController: UIViewController {

    @IBOutlet weak var CNMMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get location manager from model
        let locationManager = CoreLocation.get.locationManager
        
        //delegate location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        
        //get cinema locations
        CoreLocation.get.getCinema()
        
        //Request user to allow location tracking
        locationManager.requestWhenInUseAuthorization()
        
        //When finish getting data from api fill cinema annotations
        NotificationCenter.default.addObserver(forName: NSNotification.Name("CoordinatesDownloadedNotification"), object: nil, queue: nil) { (notification) in
            print("Coordinates ready")
            self.fillCinemaAnotation()
        }
    }
    //function to create pin annotations of cinema locations
    func fillCinemaAnotation(){
        
        //for each cinemas from api
        for cinema in CoreLocation.get.Cinemas {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(cinema.lat, cinema.lng)
            annotation.title = cinema.name
            annotation.subtitle = "Rating: \(String(cinema.rating))"
            CNMMapView.addAnnotation(annotation)
        }
    }
    
    //set up map to Map view
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        CNMMapView.setRegion(region, animated: true)
    }
    
    
}

//extension class for view controller
extension CinemaNearMeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        //User authorize
        print ("Authorization status changed to \(status.rawValue)")
        let locationManager = CoreLocation.get.locationManager
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            CNMMapView.showsUserLocation = true
        default:
            locationManager.stopUpdatingLocation()
            CNMMapView.showsUserLocation = false
        }
    }
    
}
