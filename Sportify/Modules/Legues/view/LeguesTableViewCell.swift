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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeImageCircular()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    override func layoutSubviews() {
           super.layoutSubviews()
           makeImageCircular()
       }

    func makeImageCircular() {
        legueImage.layer.cornerRadius = 55
            legueImage.layer.masksToBounds = true
        }
    
}
