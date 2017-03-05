//
//  ClassAndExtensions.swift
//  UserInfoApp
//
//  Created by Admin on 05.03.17.
//  Copyright © 2017 Freeman. All rights reserved.
//

import Foundation

struct User{
    
    let firstName: String
    let lastName: String
    let email: String
}
// initialization from json object
extension User {
    
    
    init?(json: [String : Any]){
        guard let name = json["firstName"] as? String ,
              let lname = json["lastName"] as? String,
              let mail = json["email"] as? String
        else {return nil}
        
        self.firstName = name
        self.lastName = lname
        self.email = mail
    }
    
}
