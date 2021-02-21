//
//  AddFriendViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 17/02/2021.
//

import UIKit

class AddFriendViewController: UIViewController, AddFriendCellDelegate {
    
    

    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!
    var userArray:[User] = []
    var friendsId:[Int] = []
    var api : ApiService = ApiService()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func registerTableViewCells(){
            let textFieldCell = UINib(nibName: "AddFriendTableViewCell", bundle: nil)
            self.tableView.register(textFieldCell, forCellReuseIdentifier: "AddFriendTableViewCell")
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}




extension AddFriendViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AddFriendTableViewCell") as? AddFriendTableViewCell{
            cell.delegate = self
            cell.nameLabel.text = userArray[indexPath.row].username
            return cell
        }
        return UITableViewCell()
    }
    
    func addFriend(cell: AddFriendTableViewCell) {
        //Get index, user and uid
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        let user = userArray[index]
        let idFile = self.getDocumentsDirectory().appendingPathComponent("id.txt")
        
        do {
            let uid = try String(contentsOf: idFile)
            
            //Get all friends
            self.api.getAllFriends(id: uid) { [self] (result) in
                switch result{
                case.success(let friend):
                    let arr = friend.arrayFriend
                    
                    //Place all existing friends in an array
                    for friend in arr {
                        self.friendsId.append(friend.id)
                    }
                    
                    //Append new friend id into array
                    self.friendsId.append(user.id)
                    
                    //Update user info with newly added Friend
                    api.updateFriends(friendsId: friendsId) { (result) in
                        switch result{
                        case .success(_):
                            DispatchQueue.main.async {
                                cell.addButton.setTitle("Added", for: .normal)
                            }
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
        } catch  {
            print("Failed to retrieve Id")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension AddFriendViewController : UITextFieldDelegate, UITableViewDelegate{
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let username = self.textField.text else {
            return false
        }
        if !username.isEmpty {
            //add friend + research
                api.getUserFromResearch(username: username) { (result) in
                    switch result{
                    case.success(let user):
                        self.userArray.removeAll()
                        self.userArray.append(user[0])
                        self.tableView.dataSource = self
                        self.tableView.delegate = self
                        self.registerTableViewCells()
                        self.tableView.tableFooterView = UIView()
                        self.tableView.backgroundColor = UIColor.clear
                        self.tableView.reloadData()
                        //nom du user dans la cell.
                        break
                    case .failure(let error):
                        print(error)
                    }
                }
        }
        
        return true
    }
}


/*
 
 let api = ApiService()
 
 */
