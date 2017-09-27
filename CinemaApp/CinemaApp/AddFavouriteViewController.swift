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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentMovie: Movie? = Model.get.getCurrentMovie();
        
        afTitleTextField.text = currentMovie?.title
        afReleaseTextField.text = currentMovie?.release
        afOverviewTextField.text = currentMovie?.overview
        afImageView.image = UIImage(data: Model.get.getImageData()! as Data)
        
        
    }
    
    @IBAction func AddtoFavourite(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newFavMovie = NSEntityDescription.insertNewObject(forEntityName: "FavMovie", into: context)
        
        let nsDataImage = UIImageJPEGRepresentation(afImageView.image!, 0.0)
        
        newFavMovie.setValue(afTitleTextField.text, forKey: "title")
        newFavMovie.setValue(afReleaseTextField.text, forKey: "releasedate")
        newFavMovie.setValue(afOverviewTextField.text, forKey: "overview")
        newFavMovie.setValue(afCommentTextField.text, forKey: "comment")
        newFavMovie.setValue(nsDataImage, forKey:"image")
        
        do
        {
            try context.save()
            print("saved")
            performSegue(withIdentifier: "addFavSegue", sender: self)
        }
        catch
        {
            print("error")
        }
    }
    

}
