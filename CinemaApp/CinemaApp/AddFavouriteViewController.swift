//
//  AddFavouriteViewController.swift
//  CinemaApp
//
//  Created by Riko P on 21/9/17.
//  Copyright © 2017 Riko Pratama Laimena. All rights reserved.
//

import UIKit
import CoreData

class AddFavouriteViewController: UIViewController {
    
    @IBOutlet weak var afTitleTextField: UITextField!
    @IBOutlet weak var afReleaseTextField: UITextField!
    @IBOutlet weak var afOverviewTextField: UITextField!
    @IBOutlet weak var afCommentTextField: UITextField!
    @IBOutlet weak var afImageView: UIImageView!
    
    //Get Choosen movie to use for initial form
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentMovie: Movie? = Model.get.getCurrentMovie();
        
        //Assigning initial textfield and image
        afTitleTextField.text = currentMovie?.title
        afReleaseTextField.text = currentMovie?.release
        afOverviewTextField.text = currentMovie?.overview
        afImageView.image = UIImage(data: Model.get.getImageData()! as Data)
        
        
    }
    //User tap add favourite button
    @IBAction func AddtoFavourite(_ sender: Any) {
        
        //Create context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //Adding data into Core Data
        let newFavMovie = NSEntityDescription.insertNewObject(forEntityName: "FavMovie", into: context)
        
        let nsDataImage = UIImageJPEGRepresentation(afImageView.image!, 0.0)
        
        //Set the value to save into Core Data
        newFavMovie.setValue(afTitleTextField.text, forKey: "title")
        newFavMovie.setValue(afReleaseTextField.text, forKey: "releasedate")
        newFavMovie.setValue(afOverviewTextField.text, forKey: "overview")
        newFavMovie.setValue(afCommentTextField.text, forKey: "comment")
        newFavMovie.setValue(nsDataImage, forKey:"image")
        
        do
        {
            //Save object into core data and send user to another view
            try context.save()
            print("saved")
            performSegue(withIdentifier: "addFavSegue", sender: self)
        }
        catch
        {
            print("error")
        }
    }
    
    //Send user to tab bar controller with index 1
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addFavSegue" {
            let nextView = segue.destination as! TabBarViewController
            
            nextView.selectedIndex = 1
        }
    }
    

}
