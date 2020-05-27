//
//  FavoriteAssembler.swift
//  MFlix
//
//  Created by Viet Anh on 5/22/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol FavoriteAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteViewController
    func resolve(navigationController: UINavigationController) -> FavoriteViewModel
    func resolve(navigationController: UINavigationController) -> FavoriteNavigatorType
    func resolve() -> FavoriteUseCaseType
}

extension FavoriteAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteViewController {
        let viewController = FavoriteViewController.instantiate()
        let viewModel: FavoriteViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve(navigationController: UINavigationController) -> FavoriteViewModel {
        return FavoriteViewModel(navigator: resolve(navigationController: navigationController),
                                 useCase: resolve())
    }
}

extension FavoriteAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteNavigatorType {
       return FavoriteNavigator(assembler: self,
                                navigationController: navigationController)
    }
    
    func resolve() -> FavoriteUseCaseType {
        return FavoriteUseCase(repository: resolve())
    }
}
