//
//  MovieTableViewCell.swift
//  Rotten Tomatoes
//
//  Created by Ashish Patel on 9/11/14.
//  Copyright (c) 2014 Average Techie. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelMovieTitle: UILabel!
    
    @IBOutlet weak var labelMovieSynopsis: UILabel!
    
    @IBOutlet var imageViewMoviePoster: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
