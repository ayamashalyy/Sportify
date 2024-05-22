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
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
