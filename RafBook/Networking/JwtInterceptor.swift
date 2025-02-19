//
//  JwtInterceptor.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 19.2.25..
//

import Alamofire
import Foundation

final class JWTInterceptor: RequestInterceptor {
    private let tokenProvider: TokenProvider

    init(tokenProvider: TokenProvider) {
        self.tokenProvider = tokenProvider
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        if let token = tokenProvider.token {
            request.headers.add(.authorization(bearerToken: token))
        }
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}
