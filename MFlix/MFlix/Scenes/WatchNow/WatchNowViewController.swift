//
//  WatchNowViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class WatchNowViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var tableView: UITableView!
    private var listCell = [WatchNowCellType]()
    private var storedOffsets = [Int: CGFloat]()
    var viewModel: WatchNowViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        configNavigation()
        configTableView()
    }
    
    private func configNavigation() {
        navigationItem.title = Constants.watchNowString
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configTableView() {
        tableView.do {
            $0.register(cellType: WatchNowTableViewCell.self)
            $0.rowHeight = UITableView.automaticDimension
            $0.delegate = self
            $0.estimatedRowHeight = 200
        }
    }
    
    func bindViewModel() {

        let input = WatchNowViewModel.Input(
            loadTrigger: Driver.just(())
        )
        
        let output = viewModel.transform(input)
        
        output.items
            .drive(tableView.rx.items) { [weak self] tableView, index, item in
                if !(self?.listCell.contains(item) ?? false) {
                    self?.listCell.append(item)
                }
                let indexPath = IndexPath(item: index, section: 0)
                let cell: WatchNowTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.do {
                    $0.selectionStyle = .none
                    $0.title = item.title
                }
                return cell
            }
            .disposed(by: rx.disposeBag)
    }
}

//MARK: - UITableViewDelegate
extension WatchNowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? WatchNowTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? WatchNowTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}

//MARK: - UICollectionViewDataSource
extension WatchNowViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCell[collectionView.tag].movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WatchNowCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setContentForCell(listCell[collectionView.tag].movies[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension WatchNowViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 3 / 4 - 10
        let height = collectionView.frame.height + 5
        return CGSize(width: width, height: height)
    }
}

//MARK: - StoryboardSceneBased
extension WatchNowViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.watchNow
}

