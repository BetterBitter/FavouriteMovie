//
//  MovieTableViewCell.swift
//  CinemaApp
//
//  Created by Riko P on 20/9/17.
//  Copyright © 2017 Riko Pratama Laimena. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
