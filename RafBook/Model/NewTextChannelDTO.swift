//
//  NewTextChannel.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

struct NewTextChannelDTO: Codable {
    let name: String
    let description: String
    let roles: [String]
    let categoryName: String
    let studiesName: String
    let studyProgramName: String
}
