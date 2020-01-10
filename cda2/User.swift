//
//  User.swift
//  cda2
//
//  Created by Emilio Castro on 1/9/20.
//  Copyright © 2020 Emilio Castro. All rights reserved.
//

import Foundation

struct User: Decodable {
    let access_token: String
    let token_type : String
    let expires_in: Int
    
}
