//
//  ApiClient.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 22.12.24..
//

import Foundation

class APIClient {
    static let shared = APIClient() 
    private init() {}
    
    private let session = URLSession.shared
    
    // Generic function for making requests
    func request<T: Codable>(
        endpoint: String,
        method: String,
        body: T? = nil,
        requiresAuth: Bool = false,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let url = URL(string: APIConfig.baseURL + endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requiresAuth, let token = KeychainManager.retrieveTokenFromKeychain() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
