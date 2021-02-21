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
    let FriendApi = FriendService()
    var friendsId:[Int] = Array()
    var friendsArray:[Friend] = Array()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
        //self.friendsArray.append("Antoine")
        // Do any additional setup after loading the view.
        //add friend + research
        FriendApi.getUserFromResearch(username: "test") { (result) in
            switch result{
            case.success(let user):
                print(user[0].id)
                //self.addFriend(idFriend: user[0].id, idUser: 2)
                break
            case .failure(let error):
                print(error)
            }
        }
        
        let idFile = getDocumentsDirectory().appendingPathComponent("id.txt")
        let idUser = try! String(contentsOf: idFile)
        
        FriendApi.getAllFriends(id: idUser) { (result) in
            switch result{
            case.success(let friend):
                let arr = friend.arrayFriend
                    for friend in arr {
                        self.friendsArray.append(friend)
                    }
                self.tableView.dataSource = self
                self.tableView.delegate = self
                self.tableView.tableFooterView = UIView()
                self.tableView.backgroundColor = UIColor.clear
                self.tableView.reloadData()
                break
            case .failure(let error):
                print(error)
            }
        }
        
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
                cell.usernameLabel.text = friendsArray[indexPath.row].username
                return cell
            }
        }
        
        return UITableViewCell()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func deleteFriend(idFriend:Int,idUser:Int){
        let stringId = String(idUser)
        self.FriendApi.getAllFriends(id: stringId) { [self] (result) in
            switch result{
            case.success(let friend):
                let arr = friend.arrayFriend
                for friend in arr {
                    self.friendsArray.append(friend)
                    self.friendsId.append(friend.id)
                }
                    
                for i in 0..<friendsId.count {
                    if idFriend == friendsId[i] {
                        self.friendsId.remove(at: i)
                    }
                }
                //self.friendsId.append(user[0].id)
                FriendApi.updateFriends(friendsId: friendsId) { (result) in
                    switch result{
                    case .success(let r):
                        print(r)
                        break
                    case .failure(let e):
                        print(e)
                        break
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addFriend(idFriend:Int,idUser:Int){
        let stringId = String(idUser)
        self.FriendApi.getAllFriends(id: stringId) { [self] (result) in
            switch result{
            case.success(let friend):
                let arr = friend.arrayFriend
                for friend in arr {
                    self.friendsArray.append(friend)
                    self.friendsId.append(friend.id)
                }
                self.friendsId.append(idFriend)
                FriendApi.updateFriends(friendsId: friendsId) { (result) in
                    switch result{
                    case .success(let r):
                        print(r)
                        break
                    case .failure(let e):
                        print(e)
                        break
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
