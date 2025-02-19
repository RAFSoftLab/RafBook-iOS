//
//  NetworkManager.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 19.2.25..
//

import Alamofire

final class NetworkManager {
    let session: Session

    init(tokenProvider: TokenProvider) {
        let interceptor = JWTInterceptor(tokenProvider: tokenProvider)
        session = Session(interceptor: interceptor)
    }
}

final class UnauthorizedNetworkManager {
    static let shared = UnauthorizedNetworkManager()

    let session: Session

    private init() {
        session = Session()
    }
}
