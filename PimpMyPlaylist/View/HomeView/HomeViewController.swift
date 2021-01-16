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
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }


    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
