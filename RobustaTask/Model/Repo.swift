//
//  Repo.swift
//  RobustaTask
//
//  Created by Menaim on 16/12/2021.
//

import Foundation
    
struct Repo: Codable { //2.2
    
    var name: String?
    var avatar_url: String?
    var owner: Owner?
}

struct Owner: Codable { //2.1
    var login: String?
}
