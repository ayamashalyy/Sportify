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
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
