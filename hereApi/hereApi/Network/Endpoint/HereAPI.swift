//
//  HereAPI.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

public enum HereAPI {
    case directUrl(url: URL)
}

extension HereAPI: EndpointType {
    var baseURL: URL {
        switch self {
        case .directUrl(let url):
            return url
        }
    }
    
    var path: String {
        switch self {
        case .directUrl:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    var headers: HTTPHeaders? {
        return nil
    }
}
