//
//  WatchNowTableViewCell.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class WatchNowTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var seeAllButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var movies = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.do {
            $0.register(cellType: WatchNowCollectionViewCell.self)
            $0.delegate = self
            $0.dataSource = self
        }
    }

    func setContentForCell(_ title: String,_ movies: [Movie]) {
        titleLabel.text = title
        self.movies = movies
    }
}

//MARK: - UICollectionViewDataSource
extension WatchNowTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WatchNowCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setContentForCell(movies[indexPath.row])
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension WatchNowTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 3/4 - 10
        let height = collectionView.frame.height + 5
        return CGSize(width: width, height: height)
    }
}
