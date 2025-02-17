//
//  Reaction.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

struct ReactionDTO : Codable {
    let users : [UserDTO]
    let emote : Emote
}
