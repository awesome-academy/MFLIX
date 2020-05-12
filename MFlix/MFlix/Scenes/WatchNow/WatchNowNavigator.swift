//
//  WatchNowNavigator.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol WatchNowNavigatorType {
    func toMovieDetailScreen(movie: Movie)
    func toSeeAllScreen(category: CategoryType)
}

struct WatchNowNavigator: WatchNowNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toMovieDetailScreen(movie: Movie) {
        let controller = MovieDetailViewController.instantiate()
        let useCase = MovieDetailUseCase()
        let navigator = MovieDetailNavigator(navigationController: navigationController)
        let viewModel = MovieDetailViewModel(navigator: navigator,
                                             useCase: useCase,
                                             movie: movie)
        controller.bindViewModel(to: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func toSeeAllScreen(category: CategoryType) {
        let controller = SeeAllViewController.instantiate()
        let useCase = SeeAllUseCase()
        let navigator = SeeAllNavigator(navigationController: navigationController)
        let viewModel = SeeAllViewModel(navigator: navigator,
                                        useCase: useCase,
                                        type: category)
        controller.bindViewModel(to: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}
