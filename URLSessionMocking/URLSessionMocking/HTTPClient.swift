//
//  HTTPClient.swift
//  URLSessionMocking
//
//  Created by Harish on 04/07/23.
//

import Foundation

protocol APIClient {
    func callUserAPI(url: URL) async throws -> String
    func callAPI(url: URL, completion: @escaping (String) -> Void)
}

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
    func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class HTTPClient: APIClient {
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func callUserAPI(url: URL) async throws -> String {
        do {
            let (data, response) = try await session.data(for: URLRequest(url: url))
            print("Response URL: \(String(describing: response.url?.absoluteString))")
            return "\(String(data: data, encoding: .utf8) ?? "Error")"
        }
    }
    
    func callAPI(url: URL, completion: @escaping (String) -> Void) {
        let dataTask = session.dataTask(with: url,
                                        completionHandler: { data, response, error in
            if let data = data {
                completion("\(String(data: data, encoding: .utf8) ?? "Error")")
            } else {
                completion("Error")
            }
        })
        dataTask.resume()
    }
}
