//
//  WatchNowTableViewCell.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit

final class WatchNowTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var seeAllButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.do {
            $0.register(cellType: WatchNowCollectionViewCell.self)
        }
    }
    
    private func bindViewModel(_ movies: [Movie]) {
        let viewModel = Observable<[Movie]>.from(optional: movies)
        
        viewModel
            .bind(to: collectionView.rx.items)  { collectionView, row, movie in
                let indexPath = IndexPath(item: row, section: 0)
                let cell: WatchNowCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(movie)
                return cell
            }
            .disposed(by: rx.disposeBag)
    }
    
    func setContentForCell(_ title: String, movies: [Movie]) {
        titleLabel.text = title
        bindViewModel(movies)
    }
}
