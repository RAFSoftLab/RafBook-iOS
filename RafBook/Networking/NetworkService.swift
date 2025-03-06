//
//  NetworkService.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//
import Foundation

import Alamofire

struct EmptyResponse: Decodable {}

protocol NetworkService {
    func get<U: Decodable>(urlPath: String, parameters: Parameters?) async throws -> U
    func post<T: Encodable, U: Decodable>(urlPath: String, body: T) async throws -> U
    func put<T: Encodable, U: Decodable>(urlPath: String, body: T) async throws -> U
    func patch<T: Encodable, U: Decodable>(urlPath: String, body: T) async throws -> U
    func delete<U: Decodable>(urlPath: String, parameters: Parameters?) async throws -> U
}

final class NetworkServiceImpl: NetworkService {
    private let networkManager: NetworkManager
    private let baseURL: URL

    init(networkManager: NetworkManager, baseURL: URL = URL(string: APIConfig.baseURL)!) {
        self.networkManager = networkManager
        self.baseURL = baseURL
    }
    
    private func fullURL(from urlPath: String) -> URL {
        return baseURL.appendingPathComponent(urlPath)
    }
    
    func get<U: Decodable>(urlPath: String, parameters: Parameters? = nil) async throws -> U {
        let url = fullURL(from: urlPath)
        let request = networkManager.session.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
        return try await request.serializingDecodable(U.self).value
    }
    
    func post<T: Encodable, U: Decodable>(urlPath: String, body: T) async throws -> U {
        let url = fullURL(from: urlPath)
        var urlRequest = try URLRequest(url: url, method: .post)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(body)
        
        let request = networkManager.session.request(urlRequest)
        return try await request.serializingDecodable(U.self).value
    }
    
    func put<T: Encodable, U: Decodable>(urlPath: String, body: T) async throws -> U {
        let url = fullURL(from: urlPath)
        var urlRequest = try URLRequest(url: url, method: .put)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(body)
        
        let request = networkManager.session.request(urlRequest)
        return try await request.serializingDecodable(U.self).value
    }
    
    func patch<T: Encodable, U: Decodable>(urlPath: String, body: T) async throws -> U {
        let url = fullURL(from: urlPath)
        var urlRequest = try URLRequest(url: url, method: .patch)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(body)
        
        let request = networkManager.session.request(urlRequest)
        return try await request.serializingDecodable(U.self).value
    }
    
    func delete<U: Decodable>(urlPath: String, parameters: Parameters? = nil) async throws -> U {
        let url = fullURL(from: urlPath)
        let request = networkManager.session.request(url, method: .delete, parameters: parameters, encoding: URLEncoding.default)
        return try await request.serializingDecodable(U.self).value
    }
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingFailed(String)
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .httpError(let statusCode):
            return "HTTP Error: \(statusCode)"
        case .decodingFailed(let message):
            return "Failed to decode response: \(message)"
        case .unknown(let message):
            return "Unknown error: \(message)"
        }
    }
}

