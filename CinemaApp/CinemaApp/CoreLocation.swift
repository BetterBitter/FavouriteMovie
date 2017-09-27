//
//  CoreLocation.swift
//  CinemaApp
//
//  Created by Riko Pratama Laimena on 9/27/17.
//  Copyright © 2017 Riko Pratama Laimena. All rights reserved.
//

import Foundation
import MapKit

class CoreLocation {
    static var get = CoreLocation()
    
    private init()
    {
        
    }
    
    //list of cinemas
    var Cinemas:[Cinema] = []
    
    //set the location manager
    let locationManager = CLLocationManager()
    
    
    //get list of cinemas from api call
    func getCinema(){
        
        let urlString="https://maps.googleapis.com/maps/api/place/textsearch/json?query=cinema+in+Melbourne&key=AIzaSyC0ZY1Yr_h8A6I85bELs4Tp0E-3asEOd28"
        
        let url = NSURL(string: urlString)
        
        
        URLSession.shared.dataTask(with: (url as URL?)!) { (data, response, error) in
            
            //Json Serialization process
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let cinemaArray = jsonObj!.value(forKey: "results") as? NSArray {
                    for cinema in cinemaArray {
                        if let cinemaDict = cinema as? NSDictionary {

                            var newCinema = Cinema()
                            
                            if let cinemaName = cinemaDict.value(forKey: "name")
                            {
                                newCinema.name = cinemaName as! String
                            }
                            if let cinemaRating = cinemaDict.value(forKey: "rating")
                            {
                                newCinema.rating = cinemaRating as! Double
                            }
                            
                            if let geometry = cinemaDict.value(forKey: "geometry") as? NSDictionary
                            {
                                if let location = geometry.value(forKey: "location") as? NSDictionary
                                {
                                    if let Lat = location.value(forKey: "lat")
                                    {
                                        newCinema.lat = Lat as! Double
                                    }
                                    if let Lng = location.value(forKey: "lng")
                                    {
                                        newCinema.lng = Lng as! Double
                                    }
                                    //save data into array
                                    self.Cinemas.append(newCinema)
                                }
                            }
                        }
                    }
                }
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("CoordinatesDownloadedNotification"), object: nil)
            
        }.resume()
        
    }
}
