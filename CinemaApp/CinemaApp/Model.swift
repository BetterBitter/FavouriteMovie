//
//  Model.swift
//  CinemaApp
//
//  Created by Riko Pratama Laimena on 9/25/17.
//  Copyright © 2017 Riko Pratama Laimena. All rights reserved.
//

import Foundation

class Model
{
    //set the get variable with static
    static var get = Model()
    
    private init()
    {
        
    }
    
    //array of movies and favourite movies
    var movies = [Movie]()
    var favMovieArray = [FavMovie]()
    
    //Index path for table views
    var myIndexPath:Int = 0
    var MFIndexPath:Int = 0
    
    
    //method to get movie information from api
    func downloadJson() {
        let urlString="https://api.themoviedb.org/3/movie/now_playing?api_key=81633d89fa389a87a1ead2d81fd9e0b5"
        
        let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: (url as URL?)!) { (data, response, error) in
            
            //Serialization Json process
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                if let movieArray = jsonObj!.value(forKey: "results") as? NSArray {
                    for movie in movieArray {
                        
                        if let movieDict = movie as? NSDictionary {
                            var newMovie: Movie = Movie()
                            
                            if let title = movieDict.value(forKey: "title") {
                                newMovie.title = title as! String
                            }
                            if let id = movieDict.value(forKey: "id") {
                                newMovie.id = id as! Int
                            }
                            if let release = movieDict.value(forKey: "release_date") {
                                newMovie.release = release as! String
                            }
                            if let overview = movieDict.value(forKey: "overview") {
                                newMovie.overview = overview as! String
                            }
                            if let imageShort = movieDict.value(forKey: "poster_path") {
                                let imgURL = "https://image.tmdb.org/t/p/w500" + (imageShort as? String)!
                                newMovie.imageUrl = imgURL
                            }
                            //save movie to the array
                            Model.get.movies.append(newMovie)
                        }
                    }
                }
                
            }
            //Observer-pattern send notification to trigger action
            NotificationCenter.default.post(name: NSNotification.Name("JsonDownloadedNotification"), object: nil)
            
        }.resume()
    }
    
    //function to get current movie
    func getCurrentMovie() -> Movie?
    {
        if (myIndexPath >= 0 && myIndexPath < movies.count)
        {
            return movies[myIndexPath]
        }
        else
        {
            return nil
        }
    }
    
    //method of getting chosen favourite movie
    func getCurrentFavouriteMovie() -> FavMovie?
    {
        if (MFIndexPath >= 0 && MFIndexPath < favMovieArray.count)
        {
            return favMovieArray[MFIndexPath]
        }
        else
        {
            return nil
        }
    }
    
    
    //method to convert image
    func getImageData() -> NSData?
    {
        if let imgURL = movies[myIndexPath].imageUrl {
            let url = URL(string: imgURL)
            let data = NSData(contentsOf: url!)
            return data!
        }
        else
        {
            return nil
        }
    }
    //count movie method
    func movieCount(movies:[Movie]) -> Int {
        return movies.count
    }
}
