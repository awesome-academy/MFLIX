//
//  WatchNowRepository.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import ObjectMapper

protocol WatchNowRepositoryType {
    func getUpcomingMovies(input: UpcomingRequest) -> Observable<[Movie]>
    func getTopRatedMovies(input: TopRatedRequest) -> Observable<[Movie]>
    func getPopularMovies(input: PopularRequest) -> Observable<[Movie]>
    func getNowPlayingMovies(input: NowPlayingRequest) -> Observable<[Movie]>
}

class WatchNowRepository: WatchNowRepositoryType {
    
    private let api: APIService = APIService.share
    
    func getUpcomingMovies(input: UpcomingRequest) -> Observable<[Movie]> {
        return api.request(input: input)
            .map { (response: WatchNowResponse) in
                return response.movies
            }
    }
    
    func getTopRatedMovies(input: TopRatedRequest) -> Observable<[Movie]> {
        return api.request(input: input)
            .map { (response: WatchNowResponse) in
                return response.movies
            }
    }
    
    func getPopularMovies(input: PopularRequest) -> Observable<[Movie]> {
        return api.request(input: input)
            .map { (response: WatchNowResponse) in
                return response.movies
            }
    }
    
    func getNowPlayingMovies(input: NowPlayingRequest) -> Observable<[Movie]> {
        return api.request(input: input)
            .map { (response: WatchNowResponse) in
                return response.movies
            }
    }
}
