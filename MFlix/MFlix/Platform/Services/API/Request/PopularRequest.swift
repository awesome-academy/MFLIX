//
//  PopularRequest.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

final class PopularRequest: BaseRequest {
    
    required init(page: Int) {
        let body: [String: Any] = [
            "api_key": APIKey.apiKey,
            "page": page
        ]
        super.init(url: URLs.API.popular, requestType: .get, body: body)
    }
}
