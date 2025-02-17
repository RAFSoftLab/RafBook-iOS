//
//  Login.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 22.12.24..
//

struct LoginRequestDTO: Codable {
    let username: String
    let password: String
}

struct LoginResponseDTO: Codable {
    let token: String
}
