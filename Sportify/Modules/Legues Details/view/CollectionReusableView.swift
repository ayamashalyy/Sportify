//
//  CollectionReusableView.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 27/05/2024.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "HeaderView"
       
       let titleLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
           label.textColor = .black
           return label
       }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           addSubview(titleLabel)
           // Add any additional setup code here
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       override func layoutSubviews() {
           super.layoutSubviews()
           titleLabel.frame = bounds
       }
}
