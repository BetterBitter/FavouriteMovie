//
//  FavouriteDetailsViewController.swift
//  CinemaApp
//
//  Created by Riko Pratama Laimena on 9/26/17.
//  Copyright © 2017 Riko Pratama Laimena. All rights reserved.
//

import UIKit

class FavouriteDetailsViewController: UIViewController {

    @IBOutlet weak var FDTitleLabel: UILabel!
    @IBOutlet weak var FDImageView: UIImageView!
    @IBOutlet weak var FDReleaseLabel: UILabel!
    @IBOutlet weak var FDOverviewTextView: UITextView!
    @IBOutlet weak var FDCommentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get choosen favourite movie object
        let currentFavouriteMovie: FavMovie? = Model.get.getCurrentFavouriteMovie();
        
        if (currentFavouriteMovie != nil)
        {
            self.FDTitleLabel.text = currentFavouriteMovie!.title
            self.FDReleaseLabel.text = currentFavouriteMovie!.releasedate
            self.FDOverviewTextView.text = currentFavouriteMovie!.overview
            self.FDCommentTextView.text = currentFavouriteMovie!.comment
            self.FDImageView.image = UIImage(data: currentFavouriteMovie!.image! as Data)
        }
    }
    
    //Go back to tab bar controller and show index 1
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FDBackSegue" {
            let nextView = segue.destination as! TabBarViewController
            
            nextView.selectedIndex = 1
        }
    }
}
