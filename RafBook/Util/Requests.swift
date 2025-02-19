//
//  Requests.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 14.1.25..
//

import Foundation

class Requests {
    private var url: URL?
    private var method: String = "GET"
    private var headers: [String: String] = [:]
    private var body: Data?

    init() {}

    // Set the endpoint (baseURL + path)
    func setEndpoint(_ endpoint: String) -> Requests {
        self.url = URL(string: APIConfig.baseURL + endpoint)
        return self
    }

    // Set the HTTP method
    func setMethod(_ method: String) -> Requests {
        self.method = method
        return self
    }

    // Add a custom header
    func addHeader(_ key: String, value: String) -> Requests {
        self.headers[key] = value
        return self
    }

    // Add a JSON body
    func setBody<T: Encodable>(_ body: T) -> Requests {
        do {
            self.body = try JSONEncoder().encode(body)
            self.addHeader("Content-Type", value: "application/json")
        } catch {
            print("Failed to encode body: \(error)")
        }
        return self
    }

    // Add JWT token to the Authorization header
    func addAuth() -> Requests {
        if let jwt = KeychainManager.retrieveTokenFromKeychain() {
            self.addHeader("Authorization", value: "Bearer \(jwt)")
        } else {
            print("No JWT found in Keychain.")
        }
        return self
    }

    // Build the URLRequest
    private func build() throws -> URLRequest {
        guard let url = url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    // Execute the request and decode the response
    func execute<T: Decodable>() async throws -> T {
        let request = try build()

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed("") // (error)
        }
    }

    // Execute the request without decoding
    func execute() async throws -> Data {
        let request = try build()

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        return data
    }
}
