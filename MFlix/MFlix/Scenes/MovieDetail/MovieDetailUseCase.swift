//
//  MovieDetailUseCase.swift
//  MFlix
//
//  Created by Viet Anh on 5/12/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol MovieDetailUseCaseType {
    func getMovieDetail(movie: Movie) -> Observable<MovieDetail>
    func getCastForMovie(movie: Movie) -> Observable<[Person]>
    func getSimilarMovies(movie: Movie) -> Observable<[Movie]>
    func getTrailersMovie(movie: Movie) -> Observable<[Video]>
}

struct MovieDetailUseCase: MovieDetailUseCaseType {

    private let repository = MovieDetailRepository()
    
    func getMovieDetail(movie: Movie) -> Observable<MovieDetail> {
        let request = MovieDetailRequest(movie: movie)
        return repository.getMovieDetail(input: request)
    }
    
    func getCastForMovie(movie: Movie) -> Observable<[Person]> {
        let request = MovieActorsRequest(movie: movie)
        return repository.getCastForMovie(input: request)
    }
    
    func getSimilarMovies(movie: Movie) -> Observable<[Movie]> {
        let request = SimilarMoviesRequest(movie: movie)
        return repository.getSimilarMovies(input: request)
    }
    
    func getTrailersMovie(movie: Movie) -> Observable<[Video]> {
        let request = TrailersMovieRequest(movie: movie)
        return repository.getTrailersMovie(input: request)
    }
}
