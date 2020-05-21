//
//  FavoriteNavigator.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol FavoriteNavigatorType {
    func toMovieDetailScreen(movie: Movie)
    func showAlertDelete(movie: Movie) -> Observable<Movie>
}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let navigationController: UINavigationController
    
    func showAlertDelete(movie: Movie) -> Observable<Movie> {
        let message = String(format: "Do you really want to delete %@ from favorites",
                             movie.title)
        return navigationController.showAlertView(title: "Are you sure ?",
                                        message: message,
                                        style: .alert,
                                        actions: [("Cancel", .cancel),
                                                  ("Yes", .default)])
            .filter { $0 == 1 }
            .map { _ in movie }
    }
    
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
