//
//  ViewController.swift
//  GitHubSearcher
//
//  Created by Sheryl Evangelene Pulikandala on 9/30/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var Searchbar: UISearchBar!
    var vm = ViewModel()
    var username = [UserInfo]()
    var filtered = [UserInfo]()
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblView.delegate = self
        tblView.dataSource = self
        Searchbar.delegate = self
        vm.getDataFromAPIhandler(urlString: "https://api.github.com/search/users?q=a&page=%5C(page=100)&per_page=2000")
        self.vm.closureofVM = {
            print(self.vm.arr.count)
            self.username = self.vm.arr
            self.tblView.reloadData()
        }
        self.tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
                return filtered.count
            }
            else {
                return 0
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.backgroundColor = UIColor.black
        cell?.textLabel?.textColor = UIColor.white
        cell?.imageView?.frame(forAlignmentRect: CGRect(x: 10, y: 10, width: 20, height: 20))
        
            if(self.searchActive){
                DispatchQueue.main.async {
                    print("Filter", self.filtered.count)
                    if indexPath.row < self.filtered.count{
                   
                cell?.textLabel?.text = self.filtered[indexPath.row].login
                       
                guard let imageURL = URL(string: self.filtered[indexPath.row].avatar_url!) else { return }
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                let image = UIImage(data: imageData)
                cell?.imageView?.image = image
                    }
                    else {return}
                }
            } else {
           
        }
        return cell ?? UITableViewCell()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        tblView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        tblView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
                tblView.reloadData()
            }
       
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered.removeAll()
        filtered = username.filter({ (tmp) -> Bool in
            let range = NSString(string: tmp.login).range(of: searchText, options: String.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        print("Filtered",filtered.count)
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        
        self.tblView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
}

