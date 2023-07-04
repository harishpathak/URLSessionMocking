//
//  APIClientTestUsingMockURLProtocol.swift
//  URLSessionMockingTests
//
//  Created by Harish on 04/07/23.
//

import XCTest
@testable import URLSessionMocking

final class APIClientTestUsingMockURLProtocol: XCTestCase {

    var apiClient: HTTPClient!
    var urlSession: URLSession!
    var config: URLSessionConfiguration!
    
    override func setUpWithError() throws {
        // Important Steps, injecting data with static property
        MockURLProtocol.data = "MockURLProtocol".data(using: .utf8)!
        config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        apiClient = HTTPClient(session: urlSession)
    }
    
    override func tearDownWithError() throws {
        config.protocolClasses = []
        config = nil
        apiClient = nil
        urlSession = nil
    }
    
    func test_api_using_mocked_url_protocol() async throws {
        // Arrange
        let url = URL(string: "https://www.google.com")!
        // Act
        let output = try await apiClient.callUserAPI(url: url)
        // Assert
        XCTAssertEqual(output, "MockURLProtocol", "output not matched")
    }
    
    func test_api_using_mocked_url_protocol_completion() throws {
        let expectation = self.expectation(description: "mock url protocol")
        // Arrange
        let url = URL(string: "https://www.google.com")!
        // Act
        apiClient.callAPI(url: url, completion: { output in
            // Assert
            XCTAssertEqual(output, "MockURLProtocol", "output not matched")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10)
    }

}
