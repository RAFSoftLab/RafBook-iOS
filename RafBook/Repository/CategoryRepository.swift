//
//  CategoryRepository.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//
protocol CategoryRepository{
    var categories: [CategoryDTO] { get set }
    var categoriesById: [Int64: CategoryDTO] { get set }
    func fetchCategories(studies: StudiesDTO, studyProgram: StudyProgramDTO) async throws -> [CategoryDTO]
}

class CategoryRepositoryImpl: CategoryRepository{
    private let networkService: NetworkService
    var categories: [CategoryDTO] = []
    var categoriesById: [Int64: CategoryDTO] = [:]
    
    init(networkService: NetworkService = AppContainer.shared.container.resolve(NetworkService.self)!) {
        self.networkService = networkService
    }
    
    func fetchCategories(studies: StudiesDTO, studyProgram: StudyProgramDTO) async throws -> [CategoryDTO] {
        var parameters: [String: String] = [:]
        parameters["studies"] = studies.name
        parameters["studyProgram"] = studyProgram.name
        
        let fetchedStudyPrograms: [CategoryDTO] = try await networkService.get(
            urlPath: "/categories/names",
            parameters: parameters
        )
        
        return fetchedStudyPrograms
    }
    
}
