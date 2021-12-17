//
//  ReposViewController + TableViewExtensions.swift
//  RobustaTask
//
//  Created by Menaim on 17/12/2021.
//

import Foundation
import UIKit

//MARK: - TableViewDataSource
// 3.4
extension ReposViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return searchedRepo.count
        }
        else {
            return reposPaginationArray.count
        }
        
    }
    
    //MARK: - Scroll for pagination
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = reposTableViewOutlet.dequeueReusableCell(withIdentifier: String(describing: RepoCell.self) ) as? RepoCell else {
            
            return UITableViewCell()
            
        }
        
        if searchActive {
            cell.lblRepoName.text = searchedRepo[indexPath.row].name ?? ""
            
            if let owner = searchedRepo[indexPath.row].owner {
                cell.lblOwnerName.text = owner.login ?? ""
                cell.avatarImageViewOutlet.load(urlString: owner.avatar_url ?? "") // 8.10
                
            }
        }
        else {
            cell.lblRepoName.text = reposPaginationArray[indexPath.row].name ?? ""
            
            if let owner = reposPaginationArray[indexPath.row].owner {
                cell.lblOwnerName.text = owner.login ?? ""
                cell.avatarImageViewOutlet.load(urlString: owner.avatar_url ?? "") // 8.10
                
            }
        }
        
        return cell
        
    }
    
    
}



//MARK: - TableViewDelegate
extension ReposViewController: UITableViewDelegate { //9.3
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let repoDetailsVC = RepoDetailsViewController(nibName: String(describing: RepoDetailsViewController.self), bundle: nil)
        
        if searchActive {
            repoDetailsVC.repo = self.searchedRepo[indexPath.row]
        }
        
        else {
            repoDetailsVC.repo = self.reposPaginationArray[indexPath.row]
        }
                
        self.navigationController?.pushViewController(repoDetailsVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) { //11.8
        
        if scrollView == reposTableViewOutlet {
                 
                 if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
                 {
                     
                   setPagination(numberOfPages: numberOfPages)
                 }
             }
    }
}
