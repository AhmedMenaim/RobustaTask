//
//  RepoDetailsViewController.swift
//  RobustaTask
//
//  Created by Menaim on 16/12/2021.
//

import UIKit

class RepoDetailsViewController: UIViewController {

    //MARK: - Vars
    var repo: Repo? // 9.1
    
    //MARK: - Outlets
    //9.2
    @IBOutlet weak var lblRepoID: UILabel!
    @IBOutlet weak var lblRepoFullName: UILabel!
    @IBOutlet weak var lblOwnerName: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var lblOwnerID: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        guard repo != nil else {return}
        setData()
    }

}

extension RepoDetailsViewController {
    func setData () { // 9.4
        
        guard let owner = repo!.owner else {return}
        lblOwnerName.text = owner.login ?? ""
        lblOwnerID.text = "\(owner.id ?? 0)"
        lblRepoID.text = "\(repo!.id ?? 0)"
        lblRepoFullName.text = repo!.full_name ?? ""
        lblDescription.text = repo!.description ?? ""
        imageViewAvatar.load(urlString: owner.avatar_url ?? "")
        self.title = repo!.name
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
}
