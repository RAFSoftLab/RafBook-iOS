//
//  RafBookTests.swift
//  RafBookTests
//
//  Created by Stevan Dabizljevic on 19.11.24..
//

import Testing
@testable import RafBook

struct RafBookTests {

    @Test func example() async throws {
        print("TEST STARTED")
        let repository: LoginRepository = LoginRepositoryImpl()
        let loginRequest: LoginRequestDTO = LoginRequestDTO(username: "mara", password: "mara123")
        do{
            let resp = try await repository.login(request: loginRequest)
            print(resp)
        }catch {
            print(error)
        }

    }

}
