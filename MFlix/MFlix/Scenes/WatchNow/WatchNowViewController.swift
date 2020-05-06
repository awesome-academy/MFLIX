//
//  WatchNowViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

class WatchNowViewController: UIViewController, BindableType {
    
    var viewModel: WatchNowViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        navigationItem.title = Constants.watchNowString
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func bindViewModel() {
    }
    
}

extension WatchNowViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.watchNow
}
