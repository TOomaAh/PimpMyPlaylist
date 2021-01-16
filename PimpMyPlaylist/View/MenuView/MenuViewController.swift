//
//  MenuViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var addSongButton: UIButton!
    @IBOutlet var editPlaylistButton: UIButton!
    @IBOutlet var deletePlaylistButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func customizeButton(){
        
    }

    @IBAction func addSongNext(_ sender: Any) {
        let research = ResearchViewController(nibName: "ResearchViewController", bundle: nil)
        self.navigationController?.pushViewController(research, animated: true)
    }
    @IBAction func editPlaylistNext(_ sender: Any) {
        let edit = EditPlaylistViewController(nibName: "EditPlaylistViewController", bundle: nil)
        self.navigationController?.pushViewController(edit, animated: true)
    }
    @IBAction func deletePlaylistNext(_ sender: Any) {
        let delete = DeletePlaylistViewController(nibName: "DeletePlaylistViewController", bundle: nil)
        self.navigationController?.pushViewController(delete, animated: true)
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
