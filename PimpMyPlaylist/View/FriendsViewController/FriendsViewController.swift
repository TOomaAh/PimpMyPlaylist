//
//  FriendsViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 10/02/2021.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var searchFriends: UITextField!
    @IBOutlet var tableView: UITableView!
    var friendsArray:[String] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.reloadData()
        self.registerTableViewCells()
        self.friendsArray.append("Antoine")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func registerTableViewCells(){
        
            let textFieldCell = UINib(nibName: "FriendsTableViewCell", bundle: nil)
            self.tableView.register(textFieldCell, forCellReuseIdentifier: "FriendsTableViewCell")
    
    }

}

extension FriendsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count == 0 ? 1 : friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if friendsArray.count == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell") as? FriendsTableViewCell{
                self.tableView.rowHeight = 101
                cell.usernameLabel.text = "Search for new friends"
                cell.watchlistbutton.isHidden = true
                cell.watchlistbutton.isEnabled = false
                cell.delButton.isEnabled = false
                cell.delButton.isHidden = true
                return cell
            }
        }else{
            self.tableView.rowHeight = 50
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell") as? FriendsTableViewCell{
                cell.usernameLabel.text = friendsArray[indexPath.row]
                return cell
            }
        }
        
        return UITableViewCell()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
