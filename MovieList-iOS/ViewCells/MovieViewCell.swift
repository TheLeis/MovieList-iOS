//
//  MovieViewCell.swift
//  MovieList-iOS
//
//  Created by Mananas on 4/12/25.
//

import UIKit
import Kingfisher

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func render(with movie: Movie) {
        let URL = URL(string: movie.Poster)
        nameDateLabel.text = "\(movie.Title) (\(movie.Year))"
        movieImageView.kf.setImage(with: URL, placeholder: UIImage(systemName: "film"))
    }

}
