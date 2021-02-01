//
//  HomeViewController.swift
//  PimpMyPlaylist
//
//  Created by Thomas on 10/01/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    var timer:Timer!
    var counter = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = self.getDocumentsDirectory().appendingPathComponent("login.txt")
        do {
            let input = try String(contentsOf: url)
            if input == "isConnected" {
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
            }
            
        } catch {
            let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
            self.navigationController?.pushViewController(login, animated: true)
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    @objc func updateTimer(){
        counter+=1
        if counter > 4 {
            timer?.invalidate()
            timer = nil
            let menuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
            self.navigationController?.pushViewController(menuViewController, animated: true);
        }
    }

}
