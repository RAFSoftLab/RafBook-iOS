//
//  CategoryDTO.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

struct CategoryDTO: Codable, Identifiable {
    let id: Int64
    let name: String
    let description: String
    let textChannels: [TextChannelDTO]
}
