//
//  ViewController.swift
//  RobustaTask
//
//  Created by Menaim on 16/12/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.shared.getRepo { (response: [Repo]?, error) in
            guard response != nil else {
                debugPrint(error!.localizedDescription)
                return
                
            }
            debugPrint(response!)
        }
    }


}

