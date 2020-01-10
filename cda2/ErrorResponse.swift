//
//  ErrorResponse.swift
//  cda2
//
//  Created by Emilio Castro on 1/9/20.
//  Copyright © 2020 Emilio Castro. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable, LocalizedError {
    let error: String
    var errorDescription: String?{return error}
}
 
//extension ErrorResponse {
 //   var errorValue: NSError {return NSError(domain:error, code: 0, userInfo: nil)}
//}

//struct ErrorResponse: Decodable, LocalizedError {
//let reason: String
//}
