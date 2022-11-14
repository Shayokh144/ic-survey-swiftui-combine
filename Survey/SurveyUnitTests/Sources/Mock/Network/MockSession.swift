//
//  MockSession.swift
//  SurveyUnitTests
//
//  Created by Taher on 11/11/22.
//

import Foundation

enum MockSession {

    static func make(url: URL, data: Data, statusCode: Int) -> URLSession {
        let response = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )
        let mockResponse = MockResponse(response: response ?? URLResponse(), url: url, data: data)
        MockURLProtocol.testResponses = [url: mockResponse]

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]

        return URLSession(configuration: config)
    }
}
