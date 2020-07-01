//
//  LoginViewController.swift
//  coffeeTime
//
//  Created by Keita Suzuki on 2020/07/01.
//  Copyright © 2020 Keita Suzuki. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func tapSignUpButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        self.emailTextField(email: email, password: password)
    }
    
    
    @IBAction func tapLoginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        self.emailLogin(email: email, password: password)
    }
    
    
    @IBAction func tapTermsButton(_ sender: Any) {
    }
    
    func emailSignUp(email:String, password:String){
        Auth.auth().createUser(withEmail: email, password){(result, error) in
            if let error = error as NSError? {
            } else {
                
            }
        }
    }
    
    func emailLogin(email:String, password:String){
        Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
            if let error = error as NSError? {
            } else {
                
            }
        }
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
