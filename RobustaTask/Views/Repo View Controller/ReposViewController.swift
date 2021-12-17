//
//  ReposViewController.swift
//  RobustaTask
//
//  Created by Menaim on 16/12/2021.
//

import UIKit

class ReposViewController: UIViewController {
    
    
    //MARK: - Vars
    var repoArray: [Repo] = []
    lazy var repoPresenter = RepoPresenter() // 6.1
    var searchedRepo = [Repo]() // 10.2
    var searchActive = false
    
    /// Pagination     // 11.1
    var numberOfPages = 10
    var limit = 10
    var reposPaginationArray: [Repo] = []
    
    //MARK: - Outlets
    // 3.2
    @IBOutlet weak var reposTableViewOutlet: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewAndSearchBar()
        repoPresenter.setDelegate(delegate: self) // 6.3
        repoPresenter.getRepos() //6.4
        self.title = "Repos"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    //MARK: - Set TableView & search bar
    // 3.3
    func setTableViewAndSearchBar() {
        reposTableViewOutlet.delegate = self
        reposTableViewOutlet.dataSource = self
        reposTableViewOutlet.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "RepoCell")
        
        searchBarOutlet.delegate = self //10.1
    }
}


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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reposTableViewOutlet.dequeueReusableCell(withIdentifier: "RepoCell") as! RepoCell
        
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
        
        let repoDetailsVC = RepoDetailsViewController(nibName: "RepoDetailsViewController", bundle: nil)
        
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

//MARK: - Protocol Extensions
extension ReposViewController: GetReposProtocol { // 6.2
    func presentRepos(repos: [Repo]) {
        self.repoArray = repos
        
        //11.2
        self.limit = self.repoArray.count
        
        for i in 0..<10 {
            reposPaginationArray.append(repoArray[i])
        }
        
        debugPrint(self.repoArray)
        
        DispatchQueue.main.async {
            self.reposTableViewOutlet.reloadData()
        }
    }
}

//MARK: - SearchBar Extensions
extension ReposViewController: UISearchBarDelegate { //10.3
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedRepo = repoArray.filter{(repo) -> Bool in
            return repo.name?.range(of: searchText, options: [ .caseInsensitive ]) != nil //10.4
        }
        
        //10.5
        if searchText == "" || searchText == " " {
            searchActive = false
        }
        else {
            
            searchActive = true
        }
        DispatchQueue.main.async {
            self.reposTableViewOutlet.reloadData()
            
        }
    }
}

//MARK: - Pagination
extension ReposViewController {
    
    func setPagination(numberOfPages: Int) { //11.3
        
        //11.4
        if numberOfPages >= limit {
            return
        }
        
        //11.5
        else if numberOfPages >= limit - 10 {
            for i in numberOfPages..<limit {
                reposPaginationArray.append(repoArray[i])
            }
            self.numberOfPages += 10
        }
        
        //11.6
        else {
            for i in numberOfPages..<numberOfPages + 10 {
                reposPaginationArray.append(repoArray[i])
            }
            self.numberOfPages += 10
        }
        //11.7
        DispatchQueue.main.async {
            self.reposTableViewOutlet.reloadData()
        }
    }
}
