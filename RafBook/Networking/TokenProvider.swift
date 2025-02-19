//
//  TokenProvider.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 20.2.25..
//

protocol TokenProvider: AnyObject {
    var token: String? { get set }
}

final class DefaultTokenProvider: TokenProvider, Sendable {
    var token: String?
}
