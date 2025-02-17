//
//  JwtDecoder.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 14.1.25..
//

import Foundation

class JWTDecoder {
    static func decodeJWT(_ token: String) -> [String: Any]? {
        // Split the JWT into its parts (header, payload, signature)
        let segments = token.split(separator: ".")
        guard segments.count == 3 else {
            print("Invalid JWT structure")
            return nil
        }
        
        let payloadSegment = segments[1]
        
        // Decode the Base64-encoded payload
        var payloadData = Data(base64Encoded: String(payloadSegment), options: [.ignoreUnknownCharacters])
        
        // Decode URL-safe Base64 if regular decoding fails
        if payloadData == nil {
            let base64 = String(payloadSegment)
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")
            
            payloadData = Data(base64Encoded: base64, options: [.ignoreUnknownCharacters])
        }
        
        guard let data = payloadData,
              let jsonObject = try? JSONSerialization.jsonObject(with: data),
              let json = jsonObject as? [String: Any] else {
            print("Failed to decode JWT payload")
            return nil
        }
        
        return json
    }
    
    static func printJWTClaims(_ token: String) {
        guard let claims = decodeJWT(token) else {
            print("No claims found or failed to decode JWT")
            return
        }
        
        print("Decoded JWT Claims:")
        for (key, value) in claims {
            print("\(key): \(value)")
        }
    }
}
