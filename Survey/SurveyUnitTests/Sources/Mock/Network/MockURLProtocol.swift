//
//  MockURLProtocol.swift
//  SurveyUnitTests
//
//  Created by Taher on 10/11/22.
//

import Foundation

class MockURLProtocol: URLProtocol {

    static var testResponses = [URL: MockResponse]()

    override class func canInit(with request: URLRequest) -> Bool { true }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let url = request.url {
            if let mock = MockURLProtocol.testResponses[url] {
                client?.urlProtocol(self, didReceive: mock.response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: mock.data ?? Data())
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
