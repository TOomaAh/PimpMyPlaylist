//
//  MenuViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func searchMoviesNext(_ sender: Any) {
        let research = ResearchViewController(nibName: "ResearchViewController", bundle: nil)
        self.navigationController?.pushViewController(research, animated: true)
    }
    
    @IBAction func editWatchlistNext(_ sender: Any) {
        let editWatchList = EditWatchlistViewController(nibName: "EditWatchlistViewController", bundle: nil)
        self.navigationController?.pushViewController(editWatchList, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
