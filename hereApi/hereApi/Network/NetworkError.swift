//
//  NetworkError.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation
public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Encoding parameters went wrong"
    case missingUrl = "Url is missing"
    case failedBuildRequest = "There was an issue building request"
}
