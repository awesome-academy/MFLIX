//
//  SearchNavigator.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol SearchNavigatorType {
    func toMovieDetailScreen(movie: Movie)
}

struct SearchNavigator: SearchNavigatorType {
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
}
