//
//  SeeAllViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class SeeAllViewController: UIViewController, BindableType {

    @IBOutlet private weak var collectionView: UICollectionView!
    var viewModel: SeeAllViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func bindViewModel() {
        
        let input = SeeAllViewModel.Input(loadTrigger: Driver.just(()))
        
        let output = viewModel.transform(input)
        
        output.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
    }
}

//MARK: - ConfigView
extension SeeAllViewController {
    private func configView() {
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.do {
            $0.register(cellType: SeeAllCollectionViewCell.self)
            $0.delegate = self
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SeeAllViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 1 / 2 - 10
        let height = width * 0.82
        return CGSize(width: width, height: height)
    }
}

//MARK: - StoryboardSceneBased
extension SeeAllViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.seeAll
}
