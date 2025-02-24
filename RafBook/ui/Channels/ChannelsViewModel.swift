//
//  ChannelsViewModel.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 20.2.25..
//
import Foundation

@MainActor
@Observable
final class ChannelsViewModel{
    
    var studies: [StudiesDTO] = []
    var studyPrograms: [StudyProgramDTO] = []
    var currentStudyProgram: StudyProgramDTO?
    var currentCategories: [CategoryDTO] = []
    
    @ObservationIgnored var channelsForUserUseCase: ChannelsForUserUsecase
    @ObservationIgnored let channelsRepository: TextChannelRepository
    
    init() {
        self.channelsForUserUseCase = AppContainer.shared.container.resolve(ChannelsForUserUsecase.self)!
        self.channelsRepository = AppContainer.shared.container.resolve(TextChannelRepository.self)!
    }
    
    func getInitialState() async -> [StudiesDTO] {
        do {
            let studies = try await self.channelsForUserUseCase.initialFetch()
            self.studies = studies
            self.studyPrograms = studies.first?.studyPrograms ?? []
            setCurrentStudyProgram( self.studyPrograms.first ?? nil )
            return studies
        } catch {
            print("Error fetching initial state: \(error)")
            // TODO: Handle error appropriately; for now, we return an empty array
            return []
        }
    }
    
    func setCurrentStudyProgram(_ studyProgram : StudyProgramDTO?){
        currentStudyProgram = studyProgram
        currentCategories = studyProgram?.categories ?? []
    }
}
