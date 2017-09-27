//
//  MyFavouriteViewController.swift
//  CinemaApp
//
//  Created by Riko Pratama Laimena on 9/19/17.
//  Copyright © 2017 Riko Pratama Laimena. All rights reserved.
//

import UIKit
import CoreData

class MyFavouriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var MFTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { 
        return Model.get.favMovieArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let movie = Model.get.favMovieArray[indexPath.row]
        
        cell.textLabel!.text = movie.title!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        self.fetchData()
        
        
        if editingStyle == .delete {
            let favMovie = Model.get.favMovieArray[indexPath.row]
            Model.get.favMovieArray.remove(at: indexPath.row)
            context.delete(favMovie)
            appDelegate.saveContext()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    func fetchData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do
        {
            Model.get.favMovieArray = try context.fetch(FavMovie.fetchRequest())
        }
        catch
        {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MFsegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MFsegue" {
            Model.get.MFIndexPath = sender as! Int
        }
    }
    
}
