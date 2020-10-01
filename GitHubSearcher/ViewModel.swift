//
//  ViewModel.swift
//  GitHubSearcher
//
//  Created by Sheryl Evangelene Pulikandala on 9/30/20.
//

import Foundation

class ViewModel{
    var apiH = Model()
    var closureofVM: (() -> ())?
    var arr = [UserInfo]()
    
    func getDataFromAPIhandler(urlString: String)  {
        apiH.APIhandler(url: urlString)
        apiH.closure = { data in
            self.arr = data.items
            print(self.arr)
            self.closureofVM?()
        }
        return
    }
    
    func getrows() -> Int{
        print(arr.count)
        return arr.count
    }
    
    func getObject(index: Int) -> UserInfo{
        if getrows() > 0 {
            return arr[index]
        } else{
            return UserInfo(login: "", avatar_url: "")
        }
    }
    
    func getUpperCase(string: String) -> String{
        return string.uppercased()
    }
}
