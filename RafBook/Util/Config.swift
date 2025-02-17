//
//  Config.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 8.12.24..
//

struct APIConfig {
    static let baseURL = "http://localhost:8080/api/"
}

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case decodingError
}
