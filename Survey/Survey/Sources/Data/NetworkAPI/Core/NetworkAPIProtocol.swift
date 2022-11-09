//
//  NetworkAPIProtocol.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Combine
import Foundation

protocol NetworkAPIProtocol {

    func performRequest<T: Decodable>(_ configuration: RequestConfiguration, for type: T.Type)
        -> AnyPublisher<T?, Error>
}

extension NetworkAPIProtocol {
    
    func request<T: Decodable>(
        configuration: RequestConfiguration,
        decoder: JSONDecoder
    ) throws -> AnyPublisher<T, Error> {
        guard let requestData = configuration.urlRequest else {
            throw HTTPError.invalidUrl
        }
        return URLSession.shared.dataTaskPublisher(for: requestData)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPError.invalidResponse
                }
                guard (200 ..< 300).contains(httpResponse.statusCode) else {
                    throw HTTPError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .retry(configuration.retryCount)
            .eraseToAnyPublisher()
    }
}
