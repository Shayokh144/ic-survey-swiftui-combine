//
//  LoginNetworkAPI.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Combine
import Foundation

final class LoginNetworkAPI: NetworkAPIProtocol {

    private let decoder: JSONDecoder

    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    func performRequest<T>(_ configuration: RequestConfiguration, for type: T.Type) -> AnyPublisher<T?, Error>
        where T: Decodable {
        do {
            return try request(
                configuration: configuration,
                decoder: decoder
            )
        } catch {
            NSLog(error.localizedDescription)
            return Just<T?>(nil)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
