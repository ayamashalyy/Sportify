//
//  HomeCollectionViewController.swift
//  Sportify
//
//  Created by aya on 15/05/2024.
//

import UIKit



class HomeCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    let testData = ["sport1","sports2","sports3","sports4"]
    override func viewDidLoad() {
        super.viewDidLoad()
    print("hellllllo")
      
       let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(CustomCell.self,forCellWithReuseIdentifier: "cell")
    }


   

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! CustomCell
        cell.images.image = UIImage(named:"4.png")
        
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2-20, height: 250)
    }


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tappped")
        let secondStoryboard = UIStoryboard(name: "Second", bundle: nil)
            guard let secondVC = secondStoryboard.instantiateViewController(withIdentifier: "SecondViewControllerIdentifier") as? LeguesTableViewController else {
                return
            }
        secondVC.modalPresentationStyle = .fullScreen
        present(secondVC, animated: true, completion: nil)
    }
  
}


class CustomCell :UICollectionViewCell{
    let images = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(images)
        images.translatesAutoresizingMaskIntoConstraints = false
        images.topAnchor.constraint(equalTo: topAnchor).isActive = true
        images.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        images.leadingAnchor.constraint(equalTo:leadingAnchor).isActive = true
        images.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        images.layer.cornerRadius = 20
        images.layer.masksToBounds = true
        
    }
    required init?(coder aDecoder:NSCoder) {
      fatalError("init has been imp")
    }
}
