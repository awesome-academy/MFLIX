//
//  WatchNowViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class WatchNowViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var upcomingCollectionView: UICollectionView!
    @IBOutlet private weak var popularCollectionView: UICollectionView!
    @IBOutlet private weak var topRatedCollectionView: UICollectionView!
    @IBOutlet private weak var nowPlayingCollectionView: UICollectionView!
    
    var viewModel: WatchNowViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        navigationItem.title = Constants.watchNowString
        navigationController?.navigationBar.prefersLargeTitles = true
        configCollectionView()
    }
    
    private func configCollectionView() {
        registerCell(for: upcomingCollectionView)
        registerCell(for: popularCollectionView)
        registerCell(for: topRatedCollectionView)
        registerCell(for: nowPlayingCollectionView)
    }
    
    private func registerCell(for collectionView: UICollectionView) {
        collectionView.do{
            $0.register(cellType: WatchNowCollectionViewCell.self)
        }
    }
    
    func bindViewModel() {
        let input = WatchNowViewModel.Input(
            loadTrigger: Driver.just(())
        )
        let output = viewModel.transform(input)
        
        output.nowPlaying
            .drive(nowPlayingCollectionView.rx.items) { collectionView, row, movie in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: WatchNowCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(movie)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.popular
            .drive(popularCollectionView.rx.items) { collectionView, row, movie in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: WatchNowCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(movie)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.topRated
            .drive(topRatedCollectionView.rx.items) { collectionView, row, movie in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: WatchNowCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(movie)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.upcoming
            .drive(upcomingCollectionView.rx.items) { collectionView, row, movie in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: WatchNowCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(movie)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
    }
    
}

extension WatchNowViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.watchNow
}
