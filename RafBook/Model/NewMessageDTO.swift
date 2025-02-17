//
//  NewMessageDTO.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

struct NewMessageDTO: Codable {
    let content: String
    let type: MessageType
    let mediaUrl: [String]?
    let parentMessage: Int64?
    let textChannel: Int64
}
