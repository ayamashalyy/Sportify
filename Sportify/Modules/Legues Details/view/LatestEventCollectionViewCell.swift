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
        self.clipsToBounds = false
             contentView.clipsToBounds = false
             
          
        contentView.layer.cornerRadius = 8
             contentView.backgroundColor = .white
             
             contentView.layer.shadowColor = UIColor.black.cgColor
             contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
             contentView.layer.shadowRadius = 3
             contentView.layer.shadowOpacity = 0.3
             
//             contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
//        
        
         }
         
         override func layoutSubviews() {
             super.layoutSubviews()
             
             contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
         }
}
