//
//  MockURLProtocol.swift
//  URLSessionMockingTests
//
//  Created by Harish on 04/07/23.
//

import Foundation
@testable import URLSessionMocking

// Mocking URLSesion using URLProtocol
class MockURLProtocol: URLProtocol {
    static var data: Data?
    static var error: Error?
 
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
 
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
 
    override open func startLoading() {
        if let data = Self.data {
            client?.urlProtocol(self, didReceive: URLResponse(), cacheStoragePolicy: .allowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } else if let error = Self.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
 
    override func stopLoading() {}
}
