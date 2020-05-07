//
//  WatchNowViewModel.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

struct WatchNowViewModel {
    let navigator: WatchNowNavigatorType
    let useCase: WatchNowUseCaseType
}

extension WatchNowViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        //let selectTopRatedTrigger: Driver<IndexPath>
        //let selectNowPlayingTrigger: Driver<IndexPath>
        //let selectPopularTrigger: Driver<IndexPath>
        //let selectUpcomingTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let nowPlaying: Driver<[Movie]>
        let topRated: Driver<[Movie]>
        let popular: Driver<[Movie]>
        let upcoming: Driver<[Movie]>
        //let error: Driver<Error>
        //let indicator: Driver<Bool>
        //let nowPlayingSelected: Driver<Void>
        //let topRatedSelected: Driver<Void>
        //let popularSelected: Driver<Void>
        //let upcomingSelected: Driver<Void>
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
        
        return Output(nowPlaying: nowPlayingMovies,
                      topRated: topRatedMovies,
                      popular: popularMovies,
                      upcoming: upcomingMovies)
    }
    
}
