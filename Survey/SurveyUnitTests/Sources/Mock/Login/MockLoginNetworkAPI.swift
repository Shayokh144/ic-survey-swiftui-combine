//
//  MockLoginNetworkAPI.swift
//  Survey
//
//  Created by Taher on 14/11/22.
//

import Combine
import Foundation

final class MockLoginNetworkAPI: NetworkAPIProtocol {

    func performRequest<T>(_ configuration: RequestConfiguration, for type: T.Type) -> Observable<T>
        where T: Decodable {
        guard let data = LoginTokenApi.createDummy() as? T else {
            return Fail(error: HTTPError.invalidUrl)
                .eraseToAnyPublisher()
        }
        return Just(data)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
