//
//  UpComingEventsCollectionViewCell.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 23/05/2024.
//

import UIKit

class UpComingEventsCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 25
               contentView.backgroundColor = .gray
               contentView.layer.shadowColor = UIColor.black.cgColor
               contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
               contentView.layer.shadowRadius = 4
               contentView.layer.shadowOpacity = 0.2
    }

}
