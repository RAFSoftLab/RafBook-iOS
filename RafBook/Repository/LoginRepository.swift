//
//  LoginRepository.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

import Foundation

protocol LoginRepository {
    func login(request: LoginRequestDTO, completion: @escaping (Result<LoginResponseDTO, Error>) -> Void)
}

class LoginRepositoryImpl: LoginRepository {
    private let networkService: NetworkService

    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }

    func login(request: LoginRequestDTO, completion: @escaping (Result<LoginResponseDTO, Error>) -> Void) {
        let endpoint = "/auth/login"

        networkService.post(urlPath: endpoint, body: request) { (result: Result<LoginResponseDTO, Error>) in
            completion(result)
        }
    }
}
