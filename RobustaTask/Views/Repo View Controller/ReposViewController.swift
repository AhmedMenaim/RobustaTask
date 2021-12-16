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
    
    //MARK: - Outlets
    // 3.2
    @IBOutlet weak var reposTableViewOutlet: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        repoPresenter.setDelegate(delegate: self) // 6.3
        repoPresenter.getRepos() //6.4
        self.title = "Repos"
        self.navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    
    //MARK: - Set TableView
    // 3.3
    func setTableView() {
        reposTableViewOutlet.delegate = self
        reposTableViewOutlet.dataSource = self
        reposTableViewOutlet.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "RepoCell")
        
    }
}


//MARK: - TableViewDataSource
// 3.4
extension ReposViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reposTableViewOutlet.dequeueReusableCell(withIdentifier: "RepoCell") as! RepoCell
        
        cell.lblRepoName.text = repoArray[indexPath.row].name ?? ""
        
        if let owner = repoArray[indexPath.row].owner {
            cell.lblOwnerName.text = owner.login ?? ""
            cell.avatarImageViewOutlet.load(urlString: owner.avatar_url ?? "") // 8.10

        }
       
                    
        
        return cell
        
    }
    
    
}



//MARK: - TableViewDelegate
extension ReposViewController: UITableViewDelegate { //9.3
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let repoDetailsVC = RepoDetailsViewController(nibName: "RepoDetailsViewController", bundle: nil)
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

