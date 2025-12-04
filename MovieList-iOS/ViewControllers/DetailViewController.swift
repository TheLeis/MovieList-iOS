//
//  DetailViewController.swift
//  MovieList-iOS
//
//  Created by Mananas on 4/12/25.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    // MARK: Properties
    
    var movieDetail: MovieDetail?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: Private
    
    private func configureView() {
        guard let details = movieDetail else {
            return
        }
        let URL = URL(string: details.Poster)
        nameDateLabel.text = "\(details.Title) (\(details.Year))"
        runtimeLabel.text = details.Runtime
        genreLabel.text = details.Genre
        countryLabel.text = details.Country
        directorLabel.text = "Directed by \(details.Director)"
        synopsisLabel.text = details.Plot
        movieImageView.kf.setImage(with: URL, placeholder: UIImage(systemName: "film"))
    }
}

