//
//  WatchNowViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class WatchNowViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var tableView: UITableView!
    typealias DataSource = RxTableViewSectionedReloadDataSource
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
            $0.rowHeight = 200
        }
    }
    
    func bindViewModel() {
        let dataSource = datasource()
        
        let input = WatchNowViewModel.Input(
            loadTrigger: Driver.just(())
        )
        
        let output = viewModel.transform(input)
        
        output.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
    
}

extension WatchNowViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.watchNow
}

extension WatchNowViewController {
    func datasource() -> DataSource<WacthNowSection> {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            let cell : WatchNowTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(dataSource[indexPath].title, movies: dataSource[indexPath].items)
            return cell
        })
    }
}

