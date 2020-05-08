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
    var items: [Movie]
}

enum WacthNowSection {
    case nowPlaying(items: [WatchNowCellType])
    case popular(items: [WatchNowCellType])
    case topRated(items: [WatchNowCellType])
    case watchingNow(items: [WatchNowCellType])
}

extension WacthNowSection: SectionModelType {
    typealias Item = WatchNowCellType

    var items: [WatchNowCellType] {
        switch self {
        case .nowPlaying(items: let items):
            return items
        case .popular(items: let items):
            return items
        case .topRated(items: let items):
            return items
        case .watchingNow(items: let items):
            return items
        }
    }

    init(original: WacthNowSection, items: [WatchNowCellType]) {
        switch original {
        case .nowPlaying:
            self = .nowPlaying(items: items)
        case .popular:
            self = .popular(items: items)
        case .topRated:
            self = .topRated(items: items)
        case .watchingNow:
            self = .watchingNow(items: items)
        }
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
        let sections: Driver<[WacthNowSection]>
    }
    
    func transform(_ input: WatchNowViewModel.Input) -> WatchNowViewModel.Output {
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        
        let nowPlayingMovies = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getNowPlayingMovies()
                    .debug()
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
        
        let sections = Driver.combineLatest(nowPlayingMovies,
                                            topRatedMovies,
                                            popularMovies,
                                            upcomingMovies)
            .map { n,t,p,u -> [WacthNowSection] in
                self.configDataSource(nowPlaying: n, topRated: t, popular: p, upcoming: u)
            }
        
        return Output(sections: sections)
    }
    
    private func configDataSource(nowPlaying: [Movie], topRated: [Movie],
                                  popular: [Movie], upcoming: [Movie]) -> [WacthNowSection] {
        let nowPlayingMovies = WacthNowSection.nowPlaying(items: [.init(title: "Now Playing", items: nowPlaying)])
        let topRatedgMovies = WacthNowSection.nowPlaying(items: [.init(title: "Top Rated", items: topRated)])
        let popularMovies = WacthNowSection.nowPlaying(items: [.init(title: "Popular", items: popular)])
        let upcomingMovies = WacthNowSection.nowPlaying(items: [.init(title: "Upcoming", items: upcoming)])
        
        return [nowPlayingMovies, topRatedgMovies, popularMovies, upcomingMovies]
    }
}
