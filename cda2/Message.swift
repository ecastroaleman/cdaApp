//
//  Message.swift
//  cda2
//
//  Created by Emilio Castro on 1/9/20.
//  Copyright © 2020 Emilio Castro. All rights reserved.
//

import Foundation


final class Message: Codable {
    var id:Int?
    var message:String
    
    init(message: String){
        self.message = message
    }
}
