//
//  StudyProgramRepository.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

protocol StudyProgramRepository {
    func fetchStudyPrograms(studies: StudiesDTO) async throws -> [StudyProgramDTO]
    var studyPrograms: [StudyProgramDTO] { get set }
    var studyProgramsById: [Int64: StudyProgramDTO] { get set }
}

class StudyProgramRepositoryImpl : StudyProgramRepository{
    
    private let networkService: NetworkService
    var studyPrograms: [StudyProgramDTO] = []
    var studyProgramsById: [Int64: StudyProgramDTO] = [:]
    
    init(networkService: NetworkService = AppContainer.shared.container.resolve(NetworkService.self)!) {
        self.networkService = networkService
    }
    
    func fetchStudyPrograms(studies: StudiesDTO) async throws -> [StudyProgramDTO] {
        var parameters: [String: String] = [:]
        parameters["studies"] = studies.name
        let fetchedStudyPrograms: [StudyProgramDTO] = try await networkService.get(
            urlPath: "/study-programs/by-studies",
            parameters: parameters
        )
        
        return fetchedStudyPrograms
    }
    
}
