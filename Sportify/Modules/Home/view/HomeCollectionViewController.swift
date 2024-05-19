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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return testData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! CustomCell
        cell.images.image = UIImage(named:"4.png")
        
        // Configure the cell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Customize the size of each item here
        return CGSize(width: view.frame.width/2-20, height: 250)
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tappped")
        let secondStoryboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
            guard let secondVC = secondStoryboard.instantiateViewController(withIdentifier: "SecondViewControllerIdentifier") as? LeguesTableViewController else {
                return
            }
            
            // Perform the navigation
            navigationController?.pushViewController(secondVC, animated: true)
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
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
