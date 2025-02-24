//
//  StudiesRepository.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

protocol StudiesRepository {
    /// Fetch the studies available for the user.
    func fetchStudies() async throws -> [StudiesDTO]
    var studies: [StudiesDTO] { get set }
    var studiesById: [Int64: StudiesDTO] { get set }
}

final class StudiesRepositoryImpl: StudiesRepository {
    private let networkService: NetworkService
    var studies: [StudiesDTO] = []
    var studiesById: [Int64: StudiesDTO] = [:]
    
    init(networkService: NetworkService = AppContainer.shared.container.resolve(NetworkService.self)!) {
        self.networkService = networkService
    }
    
    func fetchStudies() async throws -> [StudiesDTO] {
        let fetchedStudies: [StudiesDTO] = try await networkService.get(urlPath: "/studies", parameters: nil)
//        self.studies = fetchedStudies
//        self.studiesById = Dictionary(uniqueKeysWithValues: fetchedStudies.map { ($0.id, $0) })
        return fetchedStudies
    }
}
