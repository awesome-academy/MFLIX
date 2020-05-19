//
//  MovieDetailViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/12/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class MovieDetailViewController: UIViewController, BindableType, UITableViewDelegate {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    //MARK: - Varibale
    private var listCell = [MovieDetailTableViewCellType]()
    private var storedOffsets = [Int: CGFloat]()
    
    //MARK: - View Model
    var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func bindViewModel() {
        let input = MovieDetailViewModel.Input(loadTrigger: Driver.just(()))
        
        let output = viewModel.transform(input)
        
        output.movieDetail
            .drive(self.movieDetail)
            .disposed(by: rx.disposeBag)
        
        output.movieDetailSection
            .drive(tableView.rx.items) { [unowned self] tableView, index, item in
                if !(self.listCell.contains(item)) {
                    self.listCell.append(item)
                }
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieDetailTableViewCell.self).then {
                    $0.selectionStyle = .none
                    $0.section = item.section
                    $0.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
                }
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        tableView.rx
            .didEndDisplayingCell
            .subscribe(onNext: { cell, indexPath in
                guard let tableViewCell = cell as? MovieDetailTableViewCell else { return }
                self.storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
            })
            .disposed(by: rx.disposeBag)
    }
}

//MARK: - Config View
extension MovieDetailViewController {
    private func configView() {
        configNavigationItem()
        configTableView()
    }
    
    private func configNavigationItem() {
        navigationItem.do {
            $0.largeTitleDisplayMode = .never
            $0.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                                    style: .done, target: nil, action: nil)
        }
    }
    
    private func configTableView() {
        tableView.do {
            $0.register(cellType: MovieDetailTableViewCell.self)
            $0.rowHeight = UITableView.automaticDimension
            $0.delegate = self
        }
    }
    
    func updateView(from movie: MovieDetail) {
        titleLabel.text = movie.title
        navigationItem.title = movie.title
        descriptionTextView.text = movie.overview
        genresLabel.text = movie.genres.map { $0.name }.joined(separator: " · ")
        
        let url = movie.hasBackDropImage ?
            URL(string: movie.backdropImageW500Url) : URL(string: movie.posterImageW500Url)
        movieImageView.sd_setImage(with: url)
    }
}

//MARK: - Reactive
extension MovieDetailViewController {
    private var movieDetail: Binder<MovieDetail> {
        return Binder(self) { vc, movieDetail in
            vc.updateView(from: movieDetail)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCell[collectionView.tag].numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch listCell[collectionView.tag].items {
        case let movies as [Movie]:
            let cell: RelatedCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(movies[indexPath.row])
            return cell

        case let actors as [Person]:
            let cell: CastCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(actors[indexPath.row])
            return cell
            
        case let videos as [Video]:
            let cell: TrailerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(videos[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch listCell[collectionView.tag].items {
        case _ as [Movie], _ as [Video]:
            let width = collectionView.frame.width * 0.7
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
            
        case _ as [Person]:
            let width = collectionView.frame.width * 1 / 3
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
            
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}

//MARK: - StoryboardSceneBased
extension MovieDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movieDetail
}
