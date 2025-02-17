//
//  NetworkService.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//
import Foundation

protocol NetworkService {
    func post<T: Decodable, U: Encodable>(urlPath: String, body: U, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkServiceImpl: NetworkService {
    private let baseURL = "https://api.example.com"

    func post<T: Decodable, U: Encodable>(urlPath: String, body: U, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(urlPath)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 500, userInfo: nil)))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
