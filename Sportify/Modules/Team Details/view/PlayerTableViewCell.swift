//
//  PlayerTableViewCell.swift
//  Sportify
//
//  Created by aya on 22/05/2024.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var roalPlayer: UILabel!
    
    @IBOutlet weak var playerNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.cornerRadius = 25
        contentView.backgroundColor = .white
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
