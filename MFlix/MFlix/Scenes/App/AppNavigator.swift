//
//  AppNavigator.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol AppNavigatorType {
    func toMainTabBar()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toMainTabBar() {
        //MARK: - Watch Now
        let watchNowNavigationController = UINavigationController().then {
            $0.navigationBar.prefersLargeTitles = true
            $0.tabBarItem = UITabBarItem(title: Constants.watchNowString,
                                         image: Constants.watchNowIcon,
                                         selectedImage: Constants.watchNowFilled)
        }
        let watchNowViewController: WatchNowViewController = assembler.resolve(navigationController: watchNowNavigationController)
        watchNowNavigationController.viewControllers.append(watchNowViewController)

        //MARK: - Favorite
        let favoriteNavigationController = UINavigationController().then {
            $0.navigationBar.prefersLargeTitles = true
            $0.tabBarItem = UITabBarItem(title: Constants.favoriteString,
                                         image: Constants.favoriteIcon,
                                         selectedImage: Constants.favoriteFilled)
        }
        let favoriteViewController: FavoriteViewController = assembler.resolve(navigationController: favoriteNavigationController)
        favoriteNavigationController.viewControllers.append(favoriteViewController)

        //MARK: - Search
        let searchNavigationController = UINavigationController().then {
            $0.navigationBar.prefersLargeTitles = true
            $0.tabBarItem = UITabBarItem(title: Constants.searchString,
                                         image: Constants.searchIcon,
                                         selectedImage: Constants.searchFilled)
        }
        let searchViewController: SearchViewController = assembler.resolve(navigationController: searchNavigationController)
        searchNavigationController.viewControllers.append(searchViewController)

        //MARK: - TabBar
        let mainTabBarController = UITabBarController().then {
            $0.viewControllers = [watchNowNavigationController,
                                  favoriteNavigationController,
                                  searchNavigationController]
        }
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
    }
}
