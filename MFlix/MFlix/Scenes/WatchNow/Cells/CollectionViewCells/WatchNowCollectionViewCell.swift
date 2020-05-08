//
//  WatchNowCollectionViewCell.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit

final class WatchNowCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var movieImageView: UIImageView!
    
    func setContentForCell(_ movie: Movie) {
        movieImageView.sd_setImage(with: URL(string: movie.backdropImageOriginalUrl),
                              placeholderImage: UIImage(named: "movie_placeholder"))
    }
}
