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
        let watchNowViewController = WatchNowViewController.instantiate()
        let watchNowNavigationController = assembler.resolve(viewController: watchNowViewController).then {
            $0.tabBarItem = UITabBarItem(title: Constants.watchNowString,
                                         image: Constants.watchNowIcon,
                                         selectedImage: Constants.watchNowFilled)
        }
        
        //MARK: - Favorite
        let favoriteViewController = FavoriteViewController.instantiate()
        let favoriteNavigationController = assembler.resolve(viewController: favoriteViewController).then {
            $0.tabBarItem = UITabBarItem(title: Constants.favoriteString,
                                         image: Constants.favoriteIcon,
                                         selectedImage: Constants.favoriteFilled)
        }
        
        //MARK: - Search
        let searchViewController = SearchViewController.instantiate()
        let searchNavigationController = assembler.resolve(viewController: searchViewController).then {
            $0.tabBarItem = UITabBarItem(title: Constants.searchString,
                                         image: Constants.searchIcon,
                                         selectedImage: Constants.searchFilled)
        }
        
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
