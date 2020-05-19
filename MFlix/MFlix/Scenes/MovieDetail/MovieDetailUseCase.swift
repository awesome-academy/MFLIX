//
//  MovieDetailUseCase.swift
//  MFlix
//
//  Created by Viet Anh on 5/12/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol MovieDetailUseCaseType {
    func getMovieDetail(movie: Movie) -> Observable<MovieDetail>
    func getMovieDetailSection(of movie: Movie) -> Observable<[MovieDetailTableViewCellType]>
}

struct MovieDetailUseCase: MovieDetailUseCaseType {

    private let repository = MovieDetailRepository()
    
    func getMovieDetail(movie: Movie) -> Observable<MovieDetail> {
        let request = MovieDetailRequest(movie: movie)
        return repository.getMovieDetail(input: request)
    }
    
    func getMovieDetailSection(of movie: Movie) -> Observable<[MovieDetailTableViewCellType]> {
        let cast = getCastForMovie(movie: movie)
        let similarMovies = getSimilarMovies(movie: movie)
        let trailersMovie = getTrailersMovie(movie: movie)
        
        let movieDetailSection = Observable.combineLatest(cast, similarMovies, trailersMovie)
                .map { cast, similarMovies, trailersMovie in
                    self.configDataSource(cast: cast,
                                          similarMovies: similarMovies,
                                          trailersMovie: trailersMovie)
                }
        
        return movieDetailSection
    }
    
    private func getCastForMovie(movie: Movie) -> Observable<[Person]> {
        let request = MovieActorsRequest(movie: movie)
        return repository.getCastForMovie(input: request)
    }
    
    private func getSimilarMovies(movie: Movie) -> Observable<[Movie]> {
        let request = SimilarMoviesRequest(movie: movie)
        return repository.getSimilarMovies(input: request)
    }
    
    private func getTrailersMovie(movie: Movie) -> Observable<[Video]> {
        let request = TrailersMovieRequest(movie: movie)
        return repository.getTrailersMovie(input: request)
    }
    
    private func configDataSource(cast: [Person],
                                  similarMovies: [Movie],
                                  trailersMovie: [Video]) -> [MovieDetailTableViewCellType] {
        var array: [MovieDetailTableViewCellType] = []
        
        if !trailersMovie.isEmpty {
            array.append(.trailer(videos: trailersMovie))
        }
        
        if !similarMovies.isEmpty {
            array.append(.related(movies: similarMovies))
        }
        
        if !cast.isEmpty {
            array.append(.cast(cast: cast))
        }
        
        return array
    }
}
