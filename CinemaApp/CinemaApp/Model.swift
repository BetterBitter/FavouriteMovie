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
    static var get = Model()
    
    private init()
    {
        
    }
    
    var movies = [Movie]()
    var favMovieArray = [FavMovie]()
    
    var myIndexPath:Int = 0
    var MFIndexPath:Int = 0
    
    func downloadJson() {
        let urlString="https://api.themoviedb.org/3/movie/popular?api_key=81633d89fa389a87a1ead2d81fd9e0b5"
        
        let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: (url as URL?)!) { (data, response, error) in
            
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
                            
                            Model.get.movies.append(newMovie)
                        }
                    }
                }
                
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("JsonDownloadedNotification"), object: nil)
            
        }.resume()
    }
    
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
}
