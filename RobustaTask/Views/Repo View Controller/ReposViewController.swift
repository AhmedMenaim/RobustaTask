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
    
    //MARK: - Outlets
    @IBOutlet weak var reposTableViewOutlet: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    //MARK: - Set TableView
    func setTableView() {
        reposTableViewOutlet.delegate = self
        reposTableViewOutlet.dataSource = self
        reposTableViewOutlet.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "RepoCell")
        
    }
}

//MARK: - TableViewDataSource
extension ReposViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reposTableViewOutlet.dequeueReusableCell(withIdentifier: "RepoCell") as! RepoCell
        
        cell.lblRepoName.text = repoArray[indexPath.row].name ?? ""
        
        return cell
        
    }
    
    
}



//MARK: - TableViewDelegate
extension ReposViewController: UITableViewDelegate {
    
}
