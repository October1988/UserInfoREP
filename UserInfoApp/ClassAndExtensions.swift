//
//  ClassAndExtensions.swift
//  UserInfoApp
//
//  Created by Admin on 05.03.17.
//  Copyright © 2017 Freeman. All rights reserved.
//

import Foundation
import UIKit

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
//extension for creating md5 hash of string
extension String{
    func md5() -> String?{
        
        let str = self.trimmingCharacters(in: .whitespaces)
        guard let stringdata = str.data(using: String.Encoding.utf8)
            else {
                return nil
        }
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        _ = digestData.withUnsafeMutableBytes{
            digestBytes in
            stringdata.withUnsafeBytes{
                stringBytes in
                CC_MD5(stringBytes,CC_LONG(stringdata.count), digestBytes)
                
            }
        }
        let md5HEX = digestData.map {
            String(format: "%02hhx", $0)
            }.joined()
        return md5HEX
    }
    
}

extension UIImageView{
    func downloadAsync(from: URL, defaultNamedImage: String){
        URLSession.shared.dataTask(with: from, completionHandler: { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
                DispatchQueue.main.async(execute: { 
                    self.image = UIImage(named: defaultNamedImage)
                })
                
                return
            }else{
                DispatchQueue.main.async(execute: { 
                    let image = UIImage(data: data!)
                    self.image = image
                })
            }
            
        }).resume()
    }
}





