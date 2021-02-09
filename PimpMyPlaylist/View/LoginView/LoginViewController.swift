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
    let api = ApiService()
    
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
        
        api.connectUser(identifier:usernameInput.text!, password: passwordInput.text!) { [self] (result) in
            switch result{
            case.success(let user):
                let token = user.jwt
                let userid = user.user.id
                
                let tokenFile = getDocumentsDirectory().appendingPathComponent("token.txt")
                let idFile = getDocumentsDirectory().appendingPathComponent("id.txt")
                let login = self.getDocumentsDirectory().appendingPathComponent("login.txt")

                do {
                    try token.write(to: tokenFile, atomically: true, encoding: String.Encoding.utf8)
                    
                    let stringId = String(userid)
                    try stringId.write(to: idFile, atomically: true, encoding: String.Encoding.utf8)
                    
                    let input = "isConnected"
                    try input.write(to: login, atomically: true, encoding: String.Encoding.utf8)
                } catch {
                    print("Failed to fetch token from API")
                }
                DispatchQueue.main.async {
                    let menu = MenuViewController(nibName: "MenuViewController", bundle: nil)
                    self.navigationController?.pushViewController(menu, animated: true)
                }
            break
                
            case.failure(let e):
            print(e)
            break
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
}
