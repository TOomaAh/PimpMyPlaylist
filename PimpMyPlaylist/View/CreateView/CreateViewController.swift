//
//  CreateViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 26/01/2021.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var confirmField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClick(_ sender: Any) {
        guard usernameField.text != nil else {
            return
        }
        guard emailField.text != nil else {
            return
        }
        guard passwordField.text != nil else {
            return
        }
        guard confirmField.text != nil else {
            return
        }
        
        //Call api pour créer le compte, sur retour de l'api
        //changer de view.
    }
}
