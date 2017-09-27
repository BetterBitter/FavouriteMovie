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
        
        let locationManager = CoreLocation.get.locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        CoreLocation.get.getCinema()
        locationManager.requestAlwaysAuthorization()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("CoordinatesDownloadedNotification"), object: nil, queue: nil) { (notification) in
            print("Coordinates ready")
            self.fillCinemaAnotation()
        }
    }
    func fillCinemaAnotation(){
        for cinema in CoreLocation.get.Cinemas {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(cinema.lat, cinema.lng)
            annotation.title = cinema.name
            annotation.subtitle = "Rating: \(String(cinema.rating))"
            CNMMapView.addAnnotation(annotation)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let currentLocation = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude,currentLocation.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        CNMMapView.setRegion(region, animated: true)
    }
    
    
}

extension CinemaNearMeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
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
