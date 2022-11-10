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
    private let session: URLSession

    init(decoder: JSONDecoder, session: URLSession = .shared) {
        self.decoder = decoder
        self.session = session
        decoder.dateDecodingStrategy = .secondsSince1970
    }

    func performRequest<T>(_ configuration: RequestConfiguration, for type: T.Type) -> Observable<T> where T: Decodable {
        return request(
            configuration: configuration,
            decoder: decoder,
            session: session
        )
    }
}
