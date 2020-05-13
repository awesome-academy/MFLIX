//
//  WatchNowCollectionViewCell.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class WatchNowCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    
    func setContentForCell(_ movie: Movie) {
        titleLabel.text = movie.title
        if movie.hasBackDropImage {
            movieImageView.sd_setImage(with: URL(string: movie.backdropImageW500Url),
                                       placeholderImage: Constants.imageMoviePlaceHolder)
        } else {
            movieImageView.sd_setImage(with: URL(string: movie.posterImageW500Url),
                                       placeholderImage: Constants.imageMoviePlaceHolder)
        }
    }
}
