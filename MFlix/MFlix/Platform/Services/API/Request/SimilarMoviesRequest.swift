//
//  SimilarMoviesRequest.swift
//  MFlix
//
//  Created by Viet Anh on 5/15/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class SimilarMoviesRequest: BaseRequest {
    
    required init(movie: Movie) {
        let body: [String: Any] = [
            "api_key": APIKey.apiKey
        ]
        super.init(url: URLs.API.movie + "/\(movie.id)/similar", requestType: .get, body: body)
    }
}
