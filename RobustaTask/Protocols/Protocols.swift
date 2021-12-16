//
//  Protocols.swift
//  RobustaTask
//
//  Created by Menaim on 16/12/2021.
//

import Foundation
import UIKit

protocol GetReposProtocol: AnyObject { //4.1
    func presentRepos(repos: [Repo]) // 4.2
}

