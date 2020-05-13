//
//  Movie.swift
//  MFlix
//
//  Created by Viet Anh on 5/5/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import ObjectMapper

struct Movie {
    var id = 0
    var originalTitle = ""
    var title = ""
    private var posterPath = ""
    private var backdropPath = ""
    
    var hasBackDropImage: Bool {
        return !backdropPath.isEmpty
    }
    
    var posterImageOriginalUrl: String {
        return URLs.Image.original + posterPath
    }
    
    var posterImageW500Url: String {
        return URLs.Image.w500 + posterPath
    }
    
    var backdropImageOriginalUrl: String {
        return URLs.Image.original + backdropPath
    }
    
    var backdropImageW500Url: String {
        return URLs.Image.w500 + backdropPath
    }
}

extension Movie: Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Movie: BaseModel {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        posterPath <- map["poster_path"]
        id <- map["id"]
        backdropPath <- map["backdrop_path"]
        originalTitle <- map["original_title"]
        title <- map["title"]
    }
}
