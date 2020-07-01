//
//  ViewController.swift
//  coffeeTime
//
//  Created by Keita Suzuki on 2020/07/01.
//  Copyright © 2020 Keita Suzuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

var timer = Timer()
    
var count = 0
    
    @IBOutlet weak var timerCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.presentLoginViewController()
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

