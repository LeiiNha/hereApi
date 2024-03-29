//
//  Router.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

final class Router<Endpoint: EndpointType>: NetworkRouter {
    private var task: URLSessionTask?

    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: completion)

        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    func cancel() {
        self.task?.cancel()
    }

    private func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        var request = URLRequest(url: endpoint.baseURL,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 100.0)
        request.httpMethod = endpoint.httpMethod.rawValue
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
    }
    private func addAdditionalHeaders(_ headers: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = headers else { return }
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    private func configureParameters(bodyParameters: Parameters?,
                                     urlParameters: Parameters?,
                                     request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }

            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
}
