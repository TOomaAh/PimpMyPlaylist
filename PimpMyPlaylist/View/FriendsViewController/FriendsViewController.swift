//
//  FriendsViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 10/02/2021.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate {


    @IBOutlet var searchFriendsButton: UIButton!
    @IBOutlet var tableView: UITableView!
    var friendsArray:[Friend] = Array()
    var friendsId: [Int] = []
    let FriendApi = FriendService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllFriends()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.reloadData()
        self.registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func registerTableViewCells(){
            let textFieldCell = UINib(nibName: "FriendsTableViewCell", bundle: nil)
            self.tableView.register(textFieldCell, forCellReuseIdentifier: "FriendsTableViewCell")
    }
    
    private func getAllFriends(){
        let idFile = getDocumentsDirectory().appendingPathComponent("id.txt")
        do {
            let uId = try String(contentsOf: idFile)
            self.FriendApi.getAllFriends(id: uId) { [self] (result) in
                switch result{
                case.success(let friend):
                    let arr = friend.arrayFriend
                    for friend in arr {
                        self.friendsArray.append(friend)
                    }
                    self.tableView.reloadData()
                    if self.friendsArray.count == 0 {
                        self.tableView.isHidden = true
                    }
                case.failure(let e):
                    print(e)
                }
            }
        } catch {
            print("Failed to fetch id from File")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    @IBAction func addFriend(_ sender: Any) {
        let addFriend = AddFriendViewController(nibName: "AddFriendViewController", bundle: nil)
        self.navigationController?.pushViewController(addFriend, animated: true)
    }
    

}

extension FriendsViewController : UITableViewDataSource, friendsAction{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        self.tableView.rowHeight = 50
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell") as? FriendsTableViewCell{
            cell.delegate = self
            cell.usernameLabel.text = friendsArray[indexPath.row].username
            cell.watchlistbutton.isHidden = false
            cell.watchlistbutton.isEnabled = true
            cell.delButton.isEnabled = true
            cell.delButton.isHidden = false
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func goToWatchlist(cell: FriendsTableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        let uid = friendsArray[index].id
        let edit = EditWatchlistViewController.newInstance(nibName: "EditWatchlistViewController", id: String(uid), owned: false)
        self.navigationController?.pushViewController(edit, animated: true)
    }
    
    func deleteFriend(cell: FriendsTableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        let idFile = self.getDocumentsDirectory().appendingPathComponent("id.txt")
        do {
            let uid = try String(contentsOf: idFile)
            
            //Get all friends
            self.FriendApi.getAllFriends(id: uid) { [self] (result) in
                switch result{
                case.success(let friend):
                    let arr = friend.arrayFriend
                    
                    //Place all existing friends in an array
                    for friend in arr {
                        self.friendsId.append(friend.id)
                    }
                    //Remove friend id into array
                    self.friendsId.remove(at: index)
                    
                    //Update user info with newly added Friend
                    FriendApi.updateFriends(friendsId: friendsId) { (result) in
                        switch result{
                        case .success(_):
                            self.friendsArray.remove(at: index)
                            DispatchQueue.main.async {
                                tableView.reloadData()
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