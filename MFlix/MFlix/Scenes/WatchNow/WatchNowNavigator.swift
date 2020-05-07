//
//  WatchNowNavigator.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol WatchNowNavigatorType {
    func toMovieDetailScreen(movieId: Int)
    func toSeeAllScreen()
}

struct WatchNowNavigator: WatchNowNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toMovieDetailScreen(movieId: Int) {
    }
    
    func toSeeAllScreen() {
    }
}
