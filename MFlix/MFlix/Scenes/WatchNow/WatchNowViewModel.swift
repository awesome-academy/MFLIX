//
//  WatchNowViewModel.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

// MARK: - DataSource
struct WatchNowCellType {
    var category: CategoryType
    var movies: [Movie]
}

extension WatchNowCellType: Hashable {
    static func == (lhs: WatchNowCellType, rhs: WatchNowCellType) -> Bool {
        return lhs.category.title == rhs.category.title
    }
}

struct WatchNowViewModel {
    let navigator: WatchNowNavigatorType
    let useCase: WatchNowUseCaseType
}

// MARK: - ViewModelType
extension WatchNowViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let items: Driver<[WatchNowCellType]>
    }
    
    func transform(_ input: WatchNowViewModel.Input) -> WatchNowViewModel.Output {
        let errorTracker = ErrorTracker()
        
        let nowPlayingMovies = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getNowPlayingMovies()
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let topRatedMovies = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getTopRatedMovies()
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }

        let popularMovies = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getPopularMovies()
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }

        let upcomingMovies = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getUpcomingMovies()
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let items = Driver.combineLatest(nowPlayingMovies,
                                         topRatedMovies,
                                         popularMovies,
                                         upcomingMovies)
            .map { nowPlaying, topRated, popular, upcoming -> [WatchNowCellType] in
                self.useCase.mergeItems(nowPlayingMovies: nowPlaying,
                                        topRatedMovies: topRated,
                                        popularMovies: popular,
                                        upcomingMovies: upcoming)
            }
        
        return Output(
            items: items
        )
    }
}
