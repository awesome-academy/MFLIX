//
//  SeeAllCollectionViewCell.swift
//  MFlix
//
//  Created by Viet Anh on 5/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit

final class SeeAllCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var movieImageView: UIImageView!

    func setContentForCell(_ movie: Movie) {
        if movie.hasBackDropImage {
            movieImageView.sd_setImage(with: URL(string: movie.backdropImageW500Url),
                                       placeholderImage: Constants.imageMoviePlaceHolder)
        } else {
            movieImageView.sd_setImage(with: URL(string: movie.posterImageW500Url),
                                       placeholderImage: Constants.imageMoviePlaceHolder)
        }
    }
}