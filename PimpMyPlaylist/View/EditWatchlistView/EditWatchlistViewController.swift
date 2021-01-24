//
//  EditWatchlistViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class EditWatchlistViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Watchlist"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerTableViewCells()
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        tableView.reloadData()
    }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func registerTableViewCells(){
        let textFieldCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "CustomTableViewCell")
    }

}

extension EditWatchlistViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
            //let movie = movies[indexPath.row]
            cell.label.text = "title"
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
