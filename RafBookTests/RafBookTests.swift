//
//  RafBookTests.swift
//  RafBookTests
//
//  Created by Stevan Dabizljevic on 19.11.24..
//

import Testing
@testable import RafBook

struct RafBookTests {
    
    let glToken = "eyJhbGciOiJIUzI1NiJ9.eyJmaXJzdE5hbWUiOiJQZXRhciIsImxhc3ROYW1lIjoiU3RhbWVuaWMiLCJzdWIiOiJwZXRhciIsInJvbGVzIjpbIlNUVURFTlQiLCJTb2Z0dmVyc2tlIGtvbXBvbmVudGUiXSwiaWQiOjUsImV4cCI6MTc0MDQ2NDEzMSwiaWF0IjoxNzQwNDI4MTMxLCJlbWFpbCI6InBzdGFtZW5pYzE1MjRtQHJhZi5ycyIsInVzZXJuYW1lIjoicGV0YXIifQ.Hm-fplU4VETCxyQ99C0SuAMmz8OY9T4ijpRprsBIrPM"

    @Test func example() async throws {
        print("TEST STARTED")
//        let repository: LoginRepository = LoginRepositoryImpl()
//        let loginRequest: LoginRequestDTO = LoginRequestDTO(username: "mara", password: "mara123")
//        do{
//            let resp = try await repository.login(request: loginRequest)
//            print(resp)
//        }catch {
//            print(error)
//        }

    }
    
    @Test func example1() async throws {
//        print("TEST STARTED")
//        let repository: LoginRepository = LoginRepositoryImpl()
//        let loginRequest: LoginRequestDTO = LoginRequestDTO(username: "mara", password: "mara123")
//        do{
//            let resp = try await repository.login(request: loginRequest)
//            print(resp)
//        }catch {
//            print(error)
//        }

    }
    
    @Test func example2() async throws {

        let tokenProvider = AppContainer.shared.container.resolve(TokenProvider.self)!
        tokenProvider.token = glToken
        let channelRepository = AppContainer.shared.container.resolve(TextChannelRepository.self)!
        
        try await channelRepository.getAllChannelsForUser()

    }
    
    @Test func example3() async throws {
        
        let tokenProvider = AppContainer.shared.container.resolve(TokenProvider.self)!
        tokenProvider.token = glToken
        let channelRepository = AppContainer.shared.container.resolve(TextChannelRepository.self)!
        let studiesRepository = AppContainer.shared.container.resolve(StudiesRepository.self)!
        
        let fetchedStudies = try await studiesRepository.fetchStudies()
        
        print(fetchedStudies)
    }
    
    @Test func example4() async throws {
        
        let tokenProvider = AppContainer.shared.container.resolve(TokenProvider.self)!
        tokenProvider.token = glToken
        let channelRepository = AppContainer.shared.container.resolve(TextChannelRepository.self)!
        let studyProgramsRepo = AppContainer.shared.container.resolve(StudyProgramRepository.self)!
        let studiesRepository = AppContainer.shared.container.resolve(StudiesRepository.self)!
        
        let fetchedStudies = try await studiesRepository.fetchStudies()
        
        print(fetchedStudies[0])
        
        let programs = try await studyProgramsRepo.fetchStudyPrograms(studies: fetchedStudies[0] )
        
        print(programs)
    }
    
    @Test func example5() async throws {
        
        let tokenProvider = AppContainer.shared.container.resolve(TokenProvider.self)!
        tokenProvider.token = glToken
        let channelRepository = AppContainer.shared.container.resolve(TextChannelRepository.self)!
        let studyProgramsRepo = AppContainer.shared.container.resolve(StudyProgramRepository.self)!
        let studiesRepository = AppContainer.shared.container.resolve(StudiesRepository.self)!
        let categoriesRepo = AppContainer.shared.container.resolve(CategoryRepository.self)!
        
        let studies = try await studiesRepository.fetchStudies()
        
        print("---------")
        print("STUDIES")
        print(studies[0])
        
        let programs = try await studyProgramsRepo.fetchStudyPrograms(studies: studies[0] )
        
        print("---------")
        print("PROGRAMS")
        print(programs[0])
        
        let categories = try await categoriesRepo.fetchCategories(studies: studies[0], studyProgram: programs[1])
        
        print("---------")
        print("CATEGORIES")
        print(categories)
    }

}
