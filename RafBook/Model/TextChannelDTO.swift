//
//  TextChannel.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 8.12.24..
//

struct TextChannelDTO: Codable, Identifiable {
    let id: Int64
    let name: String
    let description: String
    let messageDTOList: [MessageDTO]
    let rolePermissionDTOList: [RolePermissionDTO]
    let canWrite: Bool
}
