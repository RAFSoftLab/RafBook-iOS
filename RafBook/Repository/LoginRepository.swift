//
//  LoginRepository.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

import Foundation

protocol LoginRepository {
    func login(request: LoginRequestDTO) async throws -> LoginResponseDTO
}

final class LoginRepositoryImpl: LoginRepository  {
    
    var loggedInUser: UserDTO?
    private let tokenProvider: TokenProvider

    init(tokenProvider: TokenProvider) {
        self.tokenProvider = tokenProvider
    }
    
    func login(request: LoginRequestDTO) async throws -> LoginResponseDTO{
        let baseURL = URL(string: APIConfig.baseURL)!
        let endpoint = "/users/auth/login"
        let url = baseURL.appendingPathComponent(endpoint)

        var urlRequest = try URLRequest(url: url, method: .post)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(request)
        
        let data = try await UnauthorizedNetworkManager.shared.session
            .request(urlRequest)
            .serializingData().value
                
        let response = try JSONDecoder().decode(LoginResponseDTO.self, from: data)
        
        guard let user = decodeJWT(response.token) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Unable to decode JWT"])
        }
        
        loggedInUser = user
        tokenProvider.token = response.token
        print(user)
        
        return response
    }
    
    func decodeJWT(_ token: String) -> UserDTO? {
        // (header, payload, signature)
        let segments = token.components(separatedBy: ".")
        guard segments.count == 3 else { return nil }
        
        var payloadSegment = segments[1]
        
        let requiredLength = 4 * ((payloadSegment.count + 3) / 4)
        let paddingLength = requiredLength - payloadSegment.count
        if paddingLength > 0 {
            payloadSegment += String(repeating: "=", count: paddingLength)
        }
        
        guard let payloadData = Data(base64Encoded: payloadSegment, options: [.ignoreUnknownCharacters]) else {
            print("Failed to base64 decode the payload.")
            return nil
        }
        
        do {
            let user = try JSONDecoder().decode(UserDTO.self, from: payloadData)
            return user
        } catch {
            print("Error decoding JWT payload: \(error)")
            return nil
        }
    }
}
