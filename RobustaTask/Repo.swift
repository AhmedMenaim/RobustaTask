//
//  Repo.swift
//  RobustaTask
//
//  Created by Menaim on 16/12/2021.
//

import Foundation

//struct RepoResponse: Codable {
//    var repoArray: [Repo]?
//}

struct Repo: Codable {
    
    var name: String?
    var avatar_url: String?
    var owner: Owner?
}

struct Owner: Codable {
    var login: String?
}
