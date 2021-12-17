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
            return repoArray.count
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
            cell.lblRepoName.text = repoArray[indexPath.row].name ?? ""
            
            if let owner = repoArray[indexPath.row].owner {
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
            repoDetailsVC.repo = self.repoArray[indexPath.row]
        }
        repoDetailsVC.repo = self.repoArray[indexPath.row]
        self.navigationController?.pushViewController(repoDetailsVC, animated: true)
    }
}

//MARK: - Protocol Extensions
extension ReposViewController: GetReposProtocol { // 6.2
    func presentRepos(repos: [Repo]) {
        self.repoArray = repos
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

