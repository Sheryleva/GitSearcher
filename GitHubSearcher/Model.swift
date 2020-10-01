//
//  Model.swift
//  GitHubSearcher
//
//  Created by Sheryl Evangelene Pulikandala on 9/30/20.
//

import Foundation

class Model {
    
    var closure : ((Users) -> ())?
    
    func APIhandler(url: String) {
        
        let urlrequest = URLRequest.init(url: URL(string: url)!)
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            let decoder = try! JSONDecoder().decode(Users.self, from: data!)
            DispatchQueue.main.async {
                self.closure?(decoder)
            }
        }.resume()
        
        
        
    }
}
