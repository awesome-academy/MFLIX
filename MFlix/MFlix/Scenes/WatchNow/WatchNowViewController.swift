//
//  WatchNowViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class WatchNowViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var tableView: UITableView!
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
            $0.estimatedRowHeight = 200
        }
    }
    
    func bindViewModel() {

        let input = WatchNowViewModel.Input(
            loadTrigger: Driver.just(())
        )
        
        let output = viewModel.transform(input)
        
        output.items
            .drive(tableView.rx.items) { tableView, index, item in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: WatchNowTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(item.title, item.movies)
                return cell
            }
        .disposed(by: rx.disposeBag)
        
    }
    
}

extension WatchNowViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.watchNow
}

