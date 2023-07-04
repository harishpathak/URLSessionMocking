//
//  APIClientTestUsingMockURLSession.swift
//  URLSessionMockingTests
//
//  Created by Harish on 04/07/23.
//

import XCTest
@testable import URLSessionMocking

final class APIClientTestUsingMockURLSession: XCTestCase {
    var apiClient: HTTPClient!
    
    override func setUpWithError() throws {
        apiClient = HTTPClient(session: MockURLSession())
    }

    override func tearDownWithError() throws {
        apiClient = nil
    }
    
    func test_api_using_dependency_injected_mock_url_session() async throws {
        // Arrange
        let url = URL(string: "https://www.google.com")!
        // Act
        let output = try await apiClient.callUserAPI(url: url)
        // Assert
        XCTAssertEqual(output, "MockURLSession", "output not matched")
    }

}
