//
//  Repo.swift
//  RobustaTask
//
//  Created by Menaim on 16/12/2021.
//

import Foundation
    
struct Repo: Codable { //2.2
    
    var id: Int?
    var name: String?
    var full_name: String?
    var description: String?
    var owner: Owner?
}

struct Owner: Codable { //2.1
    var id: Int?
    var login: String?
    var avatar_url: String?
    var html_url: String?
}
