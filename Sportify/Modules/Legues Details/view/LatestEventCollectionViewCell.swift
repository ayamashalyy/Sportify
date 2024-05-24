//
//  LatestEventCollectionViewCell.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 23/05/2024.
//

import UIKit

class LatestEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var team1Logo: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var dateLatestEvent: UILabel!
    @IBOutlet weak var timeLatestEvent: UILabel!
   
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team2Logo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

}
