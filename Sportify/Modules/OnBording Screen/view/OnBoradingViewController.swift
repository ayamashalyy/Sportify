//
//  OnBoradingViewController.swift
//  Sportify
//
//  Created by aya on 16/05/2024.
//

import UIKit

class OnBoradingViewController: UIViewController {
    @IBOutlet weak var myImage: UIImageView!
    var pageIndex: Int!
    var imageFileName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        myImage.image = UIImage(named: imageFileName)

    }
    

  
}
