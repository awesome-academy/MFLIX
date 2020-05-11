//
//  WatchNowUseCase.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol WatchNowUseCaseType {
    func getUpcomingMovies() -> Observable<[Movie]>
    func getTopRatedMovies() -> Observable<[Movie]>
    func getPopularMovies() -> Observable<[Movie]>
    func getNowPlayingMovies() -> Observable<[Movie]>
    func mergeItems(nowPlayingMovies: [Movie],
                    topRatedMovies: [Movie],
                    popularMovies: [Movie],
                    upcomingMovies: [Movie]) -> [WatchNowCellType]
}

struct WatchNowUseCase: WatchNowUseCaseType {
    
    private let repository = WatchNowRepository()
    
    func getUpcomingMovies() -> Observable<[Movie]> {
        let request = UpcomingRequest(page: 1)
        return repository.getUpcomingMovies(input: request)
    }
    
    func getTopRatedMovies() -> Observable<[Movie]> {
        let request = TopRatedRequest(page: 1)
        return repository.getTopRatedMovies(input: request)
    }
    
    func getPopularMovies() -> Observable<[Movie]> {
        let request = PopularRequest(page: 1)
        return repository.getPopularMovies(input: request)
    }
    
    func getNowPlayingMovies() -> Observable<[Movie]> {
        let request = NowPlayingRequest(page: 1)
        return repository.getNowPlayingMovies(input: request)
    }
    
    func mergeItems(nowPlayingMovies: [Movie],
                    topRatedMovies: [Movie],
                    popularMovies: [Movie],
                    upcomingMovies: [Movie]) -> [WatchNowCellType] {
        
        let nowPlayingMovies = WatchNowCellType(title: .nowPLaying,
                                                movies: nowPlayingMovies)
    
        let topRatedMovies = WatchNowCellType(title: .topRated,
                                               movies: topRatedMovies)
        
        let popularMovies = WatchNowCellType(title: .popular,
                                             movies: popularMovies)
        
        let upcomingMovies = WatchNowCellType(title: .upcoming,
                                              movies: upcomingMovies)
        
        return [nowPlayingMovies, topRatedMovies, popularMovies, upcomingMovies]
    }
}
