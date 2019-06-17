//
//  NetworkManager.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation
struct NetworkManager {
    
    private let router = Router<HereAPI>()
    
    enum NetworkResponse: String {
        case success
        case badRequest = "bad request"
        case failed = "request failed"
        case noData = "response with no data"
        case unableToDecode = "Could not decode"
        case networkFail = "Check your connection"
    }
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getDetails(url: String, completion: @escaping(_ species: Location?, _ error: String?) -> ()) {
        guard let url = URL(string: "https://places.hybrid.api.here.com/places/v1/places/6208lxx5-4b87ae261ffd095982f3c398a124e25d;context=Zmxvdy1pZD1jMTEyMTI5NC1jZjM1LTVlMmUtODQ0OS1lMWI0ZDliMzBiYmRfMTU2MDY3MTk3MjAwMl8yMzdfODgwMiZyYW5rPTU?app_id=STcFNMxGs5WeszuSC777&app_code=1AxMuqK22Wo5DjvjjrWYSw") else { completion(nil, "Error in url"); return }
        router.request(.directUrl(url: url), completion: { data, response, error in
            guard error == nil else { completion(nil, NetworkResponse.networkFail.rawValue); return }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else { completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(Location.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        })
    }
}
