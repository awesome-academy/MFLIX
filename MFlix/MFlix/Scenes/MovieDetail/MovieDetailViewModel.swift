//
//  MovieDetailViewModel.swift
//  MFlix
//
//  Created by Viet Anh on 5/12/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

// MARK: - DataSource
enum MovieDetailTableViewCellType {
    case trailer(videos: [Video])
    case related(movies: [Movie])
    case cast(cast: [Person])
    
    var section: String {
        switch self {
        case .trailer:
            return "Trailer"
        case .cast:
            return "Cast & Crew"
        case .related:
            return "Related"
        }
    }
    
    var items: Any {
        switch self {
        case .cast(let cast):
            return cast
        case .related(let movies):
            return movies
        case .trailer(let videos):
            return videos
        }
    }
    
    var numberOfItems: Int {
        switch self {
        case .cast(let cast):
            return cast.count
        case .related(let movies):
            return movies.count
        case .trailer(let videos):
            return videos.count
        }
    }
}

extension MovieDetailTableViewCellType: Equatable {
    static func == (lhs: MovieDetailTableViewCellType, rhs: MovieDetailTableViewCellType) -> Bool {
        return lhs.section == rhs.section
    }
}

//MARK: - View Model
struct MovieDetailViewModel {
    let navigator: MovieDetailNavigatorType
    let useCase: MovieDetailUseCaseType
    let movie: Movie
}

extension MovieDetailViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let movieDetail: Driver<MovieDetail>
        let movieDetailSection: Driver<[MovieDetailTableViewCellType]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let movieDetail = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getMovieDetail(movie: self.movie)
                .asDriverOnErrorJustComplete()
            }
        
        let movieDetailSection = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getMovieDetailSection(of: self.movie)
                .asDriverOnErrorJustComplete()
            }
        
        return Output(movieDetail: movieDetail,
                      movieDetailSection: movieDetailSection)
    }
}
