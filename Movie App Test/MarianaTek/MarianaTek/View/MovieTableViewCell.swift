//
//  TableCell.swift
//  MarianaTek
//

//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        if let posterPath = movie.posterPath {
            loadImageAsync(from: posterPath)
        } else {
            movieImageView.image = UIImage(named: Constants.placeHolderImage)
        }
    }
    private func loadImageAsync(from urlString: String) {
        guard let url = URL(string: "\(Constants.imagePath)\(urlString)") else {
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }
    }
}
