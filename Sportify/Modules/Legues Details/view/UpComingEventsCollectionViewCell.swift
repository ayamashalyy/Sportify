//
//  UpComingEventsCollectionViewCell.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 23/05/2024.
//

import UIKit

class UpComingEventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var team1_logo: UIImageView!
    @IBOutlet weak var team1_name: UILabel!
    @IBOutlet weak var team2_logo: UIImageView!
    @IBOutlet weak var team2_name: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
             contentView.clipsToBounds = false
             
    
             contentView.layer.cornerRadius = 25
             contentView.backgroundColor = .white
             
 
             contentView.layer.shadowColor = UIColor.black.cgColor
             contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
             contentView.layer.shadowRadius = 2
             contentView.layer.shadowOpacity = 0.3
             
     
             contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
          
             contentView.layer.borderWidth = 1.0
             contentView.layer.borderColor = UIColor.black.cgColor
         }
         
         override func layoutSubviews() {
             super.layoutSubviews()
             

             contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
         }
}
