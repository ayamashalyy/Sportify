//
//  LeguesTableViewCell.swift
//  Sportify
//
//  Created by aya on 19/05/2024.
//

import UIKit

class LeguesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var legueImage: UIImageView!
    
    @IBOutlet weak var legueLabel: UILabel!
    
    @IBOutlet weak var cellview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 0.3
        
            
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
