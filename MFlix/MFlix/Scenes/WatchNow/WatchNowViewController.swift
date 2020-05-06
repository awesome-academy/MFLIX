//
//  WatchNowViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import Then
import NSObject_Rx
import MGArchitecture
import Reusable

class WatchNowViewController: UIViewController, BindableType {
    
    var viewModel: WatchNowViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Watch Now"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func bindViewModel() {
    }

}

extension WatchNowViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.watchNow
}
