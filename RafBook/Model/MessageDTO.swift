//
//  Message.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 9.12.24..
//
import Foundation

struct MessageDTO: Codable {
    let id: Int64
    let content: String
    let createdAt: String
    let type: MessageType
    let mediaUrl: [String]?
    let sender: UserDTO
    let reactions: [ReactionDTO]?
//    let parentMessage: Message? See what to do about this one
    let deleted: Bool
    let edited: Bool
}

enum MessageType: String, Codable {
    case text = "TEXT"
    case image = "IMAGE"
    case video = "VIDEO"
    case voice = "VOICE"
}
