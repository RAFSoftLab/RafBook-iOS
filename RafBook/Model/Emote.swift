//
//  Emote.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//
import Foundation

struct Emote: Codable {
    let id: Int64
    let name: String
    let data: [Data]
}
