//
//  ViewController.swift
//  Sportify
//
//  Created by aya on 15/05/2024.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    
    @IBOutlet weak var splashScreen: AnimationView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        splashScreen.contentMode = .scaleAspectFit
        splashScreen.loopMode = .loop
        splashScreen.play()
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(changeVC), userInfo: nil, repeats: false)
    }
    @objc func changeVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "splash") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
               vc.modalTransitionStyle = .crossDissolve
               self.present(vc, animated: true)
    }


}

