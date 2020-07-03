//
//  ViewController.swift
//  coffeeTime
//
//  Created by Keita Suzuki on 2020/07/01.
//  Copyright © 2020 Keita Suzuki. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

var timer = Timer()
    
var count = 0
    
    

    @IBOutlet weak var setupNavigationBar: UINavigationBar!
    
    @IBOutlet weak var timerCountLabel: UILabel!
    
    //navigation barの設定
    private func setupNavigation(){
//画面上部のナビゲーションバーの左端にログアウトボタンを設置し、押されたらLogOut関数が走るように設定
        let leftButtonItem = UIBarButtonItem(title: "ログアウト", style: .done, target: self, action: #selector(logOut))
        navigationItem.leftBarButtonItem = leftButtonItem
    }
    // ログアウト処理
    @objc func logOut(){
        do{
            try Auth.auth().signOut()
            self.presentLoginViewController()
        } catch let signOutError as NSError{
            print("サインアウトエラー:\(signOutError)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.presentLoginViewController()
        
        if self.isLogin() == true{
        //ログイン状態の時はスキップ
        //ログインユーザーIDとログインユーザーのemailも取得できる
        print("\(String(desctibing: Auth.auth().currentUser?.uid)):ログインユーザーのユーザーID")
            print("\(String(describing: Auth.auth().currentUser?.email)):ログインユーザーのemail")
        } else {
            // まだログインしていない時はログイン画面表示
            self.presentLoginViewController()
        }
    //ログイン認証されているかどうかを判定する関数
        func isLogin() -> Bool{
            // ログインしているユーザーがいるかどうかを判定
            if Auth.auth().currentUser != nil {
                return true
            } else {
                return false
            }
        }

    }
    
    func presentLoginViewController(){
        let loginVC = LoginViewController()
        
        loginVC.modalPresentationStyle = .fullScreen
        
        self.present(loginVC, animated: false, completion: nil)
    }

    @IBAction func timerStartButton(_ sender: Any) {
        timer.invalidate()
        timer = timer.scheduledTimer(TimeInterval: 1,target: self, selector:#selector(ViewController.updateaTimer), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func timerStopButton(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func timerResetButton(_ sender: Any) {
        timer.invalidate()
        //count変数を0にする
                count = 0
        //timerCountLabelのtextプロパティへString型にキャストしたcount変数を代入する（表示させる）
                timerCountLabel.text = String(count)
    }
    @objc func updateTimer(){
        if count < 60 {
            count += 1
            timerCountLabel.text = String(count)
        }
    }
    
}

