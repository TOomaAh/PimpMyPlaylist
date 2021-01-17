//
//  ResearchViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class ResearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Research and Add"
        self.textField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let resultViewController = ResultViewController(nibName: "ResultViewController", bundle: nil)
        self.navigationController?.pushViewController(resultViewController, animated: true)
        return true
    }

}
