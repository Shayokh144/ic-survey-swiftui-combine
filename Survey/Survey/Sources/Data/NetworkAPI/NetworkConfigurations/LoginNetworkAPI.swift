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

    func performRequest<T>(_ configuration: RequestConfiguration, for type: T.Type, with urlSession: URLSession) -> Observable<T>
        where T: Decodable {
        return request(
            configuration: configuration,
            decoder: decoder,
            session: urlSession
        )
    }
}
