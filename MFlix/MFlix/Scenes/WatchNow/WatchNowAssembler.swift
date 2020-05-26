//
//  WatchNowAssembler.swift
//  MFlix
//
//  Created by Viet Anh on 5/22/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol WatchNowAssembler {
    func resolve(viewController: WatchNowViewController) -> UINavigationController
    func resolve(navigationController: UINavigationController) -> WatchNowViewModel
    func resolve(navigationController: UINavigationController) -> WatchNowNavigatorType
    func resolve() -> WatchNowUseCaseType
}

extension WatchNowAssembler {
    func resolve(viewController: WatchNowViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        let viewModel: WatchNowViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }
    
    func resolve(navigationController: UINavigationController) -> WatchNowViewModel {
        return WatchNowViewModel(navigator: resolve(navigationController: navigationController),
                                 useCase: resolve())
    }
}

extension WatchNowAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> WatchNowNavigatorType {
       return WatchNowNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> WatchNowUseCaseType {
        return WatchNowUseCase(repository: resolve())
    }
}
