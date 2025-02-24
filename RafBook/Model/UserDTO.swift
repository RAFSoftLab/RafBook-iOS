//
//  User.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 8.12.24..
//

struct UserDTO: Codable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let role: [String]
}
