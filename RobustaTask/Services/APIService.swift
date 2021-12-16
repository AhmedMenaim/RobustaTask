//
//  APIService.swift
//  RobustaTask
//
//  Created by Menaim on 16/12/2021.
//

import Foundation


class APIService {
    
    static let shared = APIService() // 1.1
    
    func getRepo(completion: @escaping(_ response: [Repo]?, _ error: Error?) -> Void) { //1.2
        
        //1.3
        let url = URL(string: "https://api.github.com/repositories")!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
           // 1.4
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            
            // 1.5
            do {
                 let decoder = JSONDecoder()
                 let response = try decoder.decode([Repo].self, from: data)
                debugPrint(response)
              completion(response, nil)

            } catch {
                debugPrint(error)
                completion(nil, error)
                
            }
        })
        task.resume() // 1.6
    }
}
