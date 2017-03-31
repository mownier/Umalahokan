//
//  CredentialList.swift
//  ServiceProvider
//
//  Created by Mounir Ybanez on 31/03/2017.
//  Copyright © 2017 Ner. All rights reserved.
//
import Core

struct Credential: Equatable {
    
    var email: String
    var password: String
    
    init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
    }
    
    static func ==(lhs: Credential, rhs: Credential) -> Bool {
        return lhs.email == rhs.email && lhs.password == rhs.password
    }
}

var credentialList: [Credential] = {
    var data = [Credential]()
    
    var credential = Credential()
    credential.email = "me@me.com"
    credential.password = "abcde12345qwert"
    data.append(credential)
    
    credential.email = "nouser@info.com"
    credential.password = "abcde12345qwert"
    data.append(credential)
    
    credential.email = "multipleuser@info.com"
    credential.password = "abcde12345qwert"
    data.append(credential)
    
    return data
}()

func userIdForEmail(_ email: String) -> String {
    switch email {
    case "me@me.com": return "me12345"
    case "nouser@info.com": return "nouser12345"
    case "multipleuser@info.com": return "multipleuser12345"
    default: return ""
    }
}
