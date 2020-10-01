//
//  UserInfo.swift
//  GitHubSearcher
//
//  Created by Sheryl Evangelene Pulikandala on 9/30/20.
//

import Foundation

struct Users: Codable{
    var items : [UserInfo]
}

struct UserInfo: Codable {
    var login: String
    var avatar_url: String?
}
