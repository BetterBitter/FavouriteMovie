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
        //Fetching data from core data
        self.fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //Show view table with core data information
        return Model.get.favMovieArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //get object from core data and show it in each cell
        let movie = Model.get.favMovieArray[indexPath.row]
        
        cell.textLabel!.text = movie.title!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //Setting up context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        self.fetchData()
        
        //Deleting function
        //Delete with swipe
        if editingStyle == .delete {
            //set object for deletion
            let favMovie = Model.get.favMovieArray[indexPath.row]
            //delete object from movieArray
            Model.get.favMovieArray.remove(at: indexPath.row)
            //delete object from coreData
            context.delete(favMovie)
            appDelegate.saveContext()
            
            //Reload table from main thread
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    //function to fetch data from core data
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
    
    //User select favourite movie
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MFsegue", sender: indexPath.row)
    }
    
    //Send identifier for the chosen cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MFsegue" {
            Model.get.MFIndexPath = sender as! Int
        }
    }
    
}
