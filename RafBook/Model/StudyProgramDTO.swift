//
//  StudyProgramDTO.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

struct StudyProgramDTO: Codable, Identifiable {
    let id: Int64
    let name: String?
    let description: String
    let categories: [CategoryDTO]
}
