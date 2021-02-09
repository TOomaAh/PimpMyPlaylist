//
//  LoginViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 26/01/2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var usernameInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.setTitle(NSLocalizedString("controller.login.logButton", comment: ""), for: .normal)
    }
    
    
    
    @IBAction func onClick(_ sender: Any) {
        guard usernameInput.text != nil else {
            return
        }
        guard passwordInput.text != nil else {
            return
        }
        //Api Login with usernameInput && passwordInput
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
}
