//
//  RepoPresenter.swift
//  RobustaTask
//
//  Created by Menaim on 16/12/2021.
//

import Foundation
import UIKit

class RepoPresenter { // 5
    
    //MARK: - Vars
    typealias RepoPresenter = GetReposProtocol & UIViewController // 5.1
    weak var delegate: RepoPresenter? // 5.2
    
}

//MARK: - Get Repos
extension RepoPresenter {
    
    func getRepos() {// 5.3
        
        APIService.shared.getRepo { (response: [Repo]?, error) in // 5.4
            guard response != nil , error == nil else {
                debugPrint(error!)
                return
            }
            
            self.delegate?.presentRepos(repos: response!) // 5.5
            
        }
    }
    
    //MARK: - Set Delegate
    
    func setDelegate(delegate: RepoPresenter) { // 5.6
        self.delegate = delegate
    }
}
