//
//  EditFavouriteViewController.swift
//  CinemaApp
//
//  Created by Riko Pratama Laimena on 9/26/17.
//  Copyright © 2017 Riko Pratama Laimena. All rights reserved.
//

import UIKit

class EditFavouriteViewController: UIViewController {

    @IBOutlet weak var EFImageView: UIImageView!
    @IBOutlet weak var EFTitleTextField: UITextField!
    @IBOutlet weak var EFReleaseTextField: UITextField!
    @IBOutlet weak var EFOverviewTextField: UITextField!
    @IBOutlet weak var EFCommentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentFavouriteMovie: FavMovie? = Model.get.getCurrentFavouriteMovie()
        
        EFTitleTextField.text = currentFavouriteMovie?.title
        EFReleaseTextField.text = currentFavouriteMovie?.releasedate
        EFOverviewTextField.text = currentFavouriteMovie?.overview
        EFCommentTextField.text = currentFavouriteMovie?.comment
        EFImageView.image = UIImage(data: currentFavouriteMovie!.image! as Data)

    }
    //User tap on done editing
    @IBAction func EFDoneTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //get current edited movie from fav movie array
        let FavMovieEdit = Model.get.favMovieArray[Model.get.MFIndexPath]
        
        //set the new value
        FavMovieEdit.setValue(EFTitleTextField.text, forKey: "title")
        FavMovieEdit.setValue(EFReleaseTextField.text, forKey: "releasedate")
        FavMovieEdit.setValue(EFOverviewTextField.text, forKey: "overview")
        FavMovieEdit.setValue(EFCommentTextField.text, forKey: "comment")
        let imageData = UIImagePNGRepresentation(EFImageView.image!) as NSData?
        
        FavMovieEdit.setValue(imageData, forKey:"image")
        
        do
        {
            //save it to core data and go to the next view controller
            try context.save()
            print("saved")
            performSegue(withIdentifier: "EFDoneSegue", sender: self)
        }
        catch
        {
            print("error")
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
    
    //When user cancel/done editing process go to tab bar controller with index 1
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EFCancelSegue" {
            let nextView = segue.destination as! TabBarViewController
            
            nextView.selectedIndex = 1
        }
        if segue.identifier == "EFDoneSegue" {
            let nextView = segue.destination as! TabBarViewController
            
            nextView.selectedIndex = 1
        }
    }
    
}
