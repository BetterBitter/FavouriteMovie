//
//  MovieDetailsViewController.swift
//  CinemaApp
//
//  Created by Riko Pratama Laimena on 9/19/17.
//  Copyright © 2017 Riko Pratama Laimena. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var detailsImgView: UIImageView!
    @IBOutlet weak var detailsTitleLabel: UILabel!
    @IBOutlet weak var detailsReleaseLabel: UILabel!
    @IBOutlet weak var detailsOverviewTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let currentMovie: Movie? = Model.get.getCurrentMovie();
        if (currentMovie != nil)
        {
            self.detailsTitleLabel.text = currentMovie!.title
            self.detailsReleaseLabel.text = currentMovie!.release
            self.detailsOverviewTextView.text = currentMovie!.overview
            self.detailsImgView.image = UIImage(data: Model.get.getImageData()! as Data)
        }
    }
}
