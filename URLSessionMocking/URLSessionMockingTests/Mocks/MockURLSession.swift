//
//  MockURLSession.swift
//  URLSessionMockingTests
//
//  Created by Harish on 04/07/23.
//

import Foundation
@testable import URLSessionMocking

class MockURLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            // Actual API call
            completionHandler(data, response, error)
        }
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        // Fake API call
        return ("MockURLSession".data(using: .utf8)!, URLResponse(url: URL(string: "https://www.google.com")!, mimeType: "", expectedContentLength: 0, textEncodingName: ""))
    }
}
