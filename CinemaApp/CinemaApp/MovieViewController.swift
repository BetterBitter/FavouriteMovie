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
        
        Model.get.downloadJson()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("JsonDownloadedNotification"), object: nil, queue: nil) { (notification) in
            self.tableView.reloadData()
            print("tableview refresh")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //print(Model.get.movies.count)
        return Model.get.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MovieTableViewCell
        
        cell.titleLabel.text = Model.get.movies[indexPath.row].title
        
        let imgURL = URL(string: (Model.get.movies[indexPath.row].imageUrl)!)
        
        if imgURL != nil {
            let data = NSData(contentsOf: imgURL!)
            cell.imgView.image = UIImage(data: data! as Data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: indexPath.row)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
                Model.get.myIndexPath = sender as! Int
        }
    }

}
    


