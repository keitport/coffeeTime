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
    
    func showAlert(title: String, message: String?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default,handler:  nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func signUpErrAlert(_error: NSError){
        if let errCode = AuthErrorCode(rawValue: error.code){
            var message = ""
            switch errCode {
            case .invalidEmail:      message = "有効なメールアドレスを入力してください"
            case .emailAlreadyInUse: message = "既に登録されているメールアドレスです"
            case .weakPassword:      message = "パスワードは６文字以上で入してください"
            default:                 message = "エラー\(error:.localizedDescription)"
            }
            self.showeAlert(title: "登録できません", message: message)
        }
    }
    
    func signInErrAlert(_ error: NSError){
        if let errCode = AuthErrorCode(rawValue: error.code){
            var message = ""
            
            switch errCode {
            case .useNotFound:   message = ""
            case .wrongPassword: message = ""
            case .userDisabled:  message = ""
            case .invalidEmail:  message = ""
            default:             message = "エラー:\(error.localizedDescription)"
            }
            self.showAlert(title: "ログインできません", message: message)
        }
    }
    
        
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
    
    @IBAction func tapSignUpButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if email.isEmpty && password,isEmpty{
            self.showAlert(title:"エラー", message:"メールアドレスとパスワードを入力して下さい")
        } else if email.isEmpty {
            self.showAlert(title: "エラー", message:"メールアドレスを入力して下さい")
        } else if password.isEmpty {
            self.showAlert(title: "エラー", message:"パスワードを入力して下さい")
        } else {
        self.emailTextField(email: email, password: password)
    }
}
    
    
    @IBAction func tapLoginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if email.isEmpty && password.isEmpty{
            self.showAlert(title:"エラー", message:"メールアドレスとパスワードを入力して下さい")
                } else if email.isEmpty {
                    self.showAlert(title: "エラー", message:"メールアドレスを入力して下さい")
                } else if password.isEmpty {
                    self.showAlert(title: "エラー",message:"パスワードを入力して下さい")
                } else {
                  self.emailLogin(email: email, password: password)
            }
        }
    
    
    @IBAction func tapTermsButton(_ sender: Any) {
    }
    
    func emailSignUp(email:String, password:String){
        Auth.auth().createUser(withEmail: email, password){(result, error) in
            if let error = error as NSError? {
                self.signUpErrAlert(error)
            } else {
                //成功時の処理
                self.presentViewController()
            }
        }
    }
    
    func emailLogin(email:String, password:String){
        Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
            if let error = error as NSError? {
                self.signInErrAlert(error)
            } else {
                self.presentViewController()
            }
        }
    }
    
    func presentViewController(){
        self.dismiss(animated: true, completion: nil)
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
