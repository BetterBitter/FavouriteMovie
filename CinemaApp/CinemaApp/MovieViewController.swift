//
//  MovieViewController.swift
//  CinemaApp
//
//  Created by Riko Pratama Laimena on 9/19/17.
//  Copyright © 2017 Riko Pratama Laimena. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Download Json data from API
        Model.get.downloadJson()
        
        //Use Observer-Pattern to reload tableview
        NotificationCenter.default.addObserver(forName: NSNotification.Name("JsonDownloadedNotification"), object: nil, queue: nil) { (notification) in
            self.tableView.reloadData()
            //printing to see if observer-pattern works
            print("tableview refresh")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //Number of table cell is equal to number of movies from API
        return Model.get.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MovieTableViewCell
        
        //Assigning each cell with movie title
        cell.titleLabel.text = Model.get.movies[indexPath.row].title
        
        //Get image URL
        let imgURL = URL(string: (Model.get.movies[indexPath.row].imageUrl)!)
        
        //Set each cell with movie image
        if imgURL != nil {
            let data = NSData(contentsOf: imgURL!)
            cell.imgView.image = UIImage(data: data! as Data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: indexPath.row)
    }
    
    //Passing sender index path (Saving user choice of which table)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
                Model.get.myIndexPath = sender as! Int
        }
    }

}
    


