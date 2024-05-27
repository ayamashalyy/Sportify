//
//  TeamsCollectionViewCell.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 23/05/2024.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = false
             contentView.clipsToBounds = false
             
    
        contentView.layer.cornerRadius = 25
             contentView.backgroundColor = .white
             
             contentView.layer.shadowColor = UIColor.black.cgColor
             contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
             contentView.layer.shadowRadius = 3
             contentView.layer.shadowOpacity = 0.3
          
             contentView.layer.borderWidth = 1.0
             contentView.layer.borderColor = UIColor.black.cgColor
         }
         
         override func layoutSubviews() {
             super.layoutSubviews()
             

             contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
         }
    }


