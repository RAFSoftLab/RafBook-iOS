//
//  TextChannelrepository.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

protocol TextChannelRepository {
    var textChannels: [TextChannelDTO] { get set }
    var textChannelsById: [Int64: TextChannelDTO] { get set }
    func getAllChannelsForUser() async throws -> [StudiesDTO]
}

class TextChannelRepositoryImpl: TextChannelRepository {
    var textChannels: [TextChannelDTO] = []
    var textChannelsById: [Int64 : TextChannelDTO] = [:]

    private let networkService: NetworkService
    
    init() {
        self.networkService = AppContainer.shared.container.resolve(NetworkService.self)!
    }
    
    func getAllChannelsForUser() async throws -> [StudiesDTO] {
        do {
            let studies: [StudiesDTO] = try await networkService.get(urlPath: "/text-channel/for-user", parameters: nil)
            return studies
        } catch {
            print("Error fetching categories:", error)
            return []
        }
    }
}
