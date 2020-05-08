//
//  WatchNowViewModel.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

// MARK: - DataSource
struct WatchNowCellType {
    var title: String
    var movies: [Movie]
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
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        
        let nowPlayingMovies = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getNowPlayingMovies()
                    .trackError(error)
                    .trackActivity(indicator)
                    .asDriverOnErrorJustComplete()
                
            }
        
        let topRatedMovies = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getTopRatedMovies()
                    .trackError(error)
                    .trackActivity(indicator)
                    .asDriverOnErrorJustComplete()
            }

        let popularMovies = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getPopularMovies()
                    .trackError(error)
                    .trackActivity(indicator)
                    .asDriverOnErrorJustComplete()
            }

        let upcomingMovies = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getUpcomingMovies()
                    .trackError(error)
                    .trackActivity(indicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let items = Driver.combineLatest(nowPlayingMovies, topRatedMovies,
                                         popularMovies, upcomingMovies)
            .map { nowPlaying, topRated,
                popular, upcoming -> [WatchNowCellType] in
                self.mergeItems(nowPlaying, topRated,
                                      popular, upcoming)
            }
        
        return Output(items: items)
    }
    
    private func mergeItems(_ nowPlaying: [Movie],_ topRated: [Movie],
                                  _ popular: [Movie],_ upcoming: [Movie]) -> [WatchNowCellType] {
        let nowPlayingMovies = WatchNowCellType(title: "Now Playing", movies: nowPlaying)
        let topRatedgMovies = WatchNowCellType(title: "Top Rated", movies: topRated)
        let popularMovies = WatchNowCellType(title: "Popular", movies: popular)
        let upcomingMovies = WatchNowCellType(title: "Upcoming", movies: upcoming)
        
        return [nowPlayingMovies, topRatedgMovies, popularMovies, upcomingMovies]
    }
}
