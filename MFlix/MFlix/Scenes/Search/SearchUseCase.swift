//
//  SearchUseCase.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol SearchUseCaseType {
    func searchListMovie(query: String) -> Observable<PagingInfo<Movie>>
    func loadMoreMovie(query: String, page: Int) -> Observable<PagingInfo<Movie>>
}

struct SearchUseCase: SearchUseCaseType {

    private let repository = SearchRepository()
    
    func searchListMovie(query: String) -> Observable<PagingInfo<Movie>> {
        return loadMoreMovie(query: query, page: 1)
    }
    
    func loadMoreMovie(query: String, page: Int) -> Observable<PagingInfo<Movie>> {
        let text = query.isEmpty ? "abcdefghjklm" : query
        let request = SearchRequest(query: text, page: page)
        return repository.searchMovieList(input: request)
    }
}

