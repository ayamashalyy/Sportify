//
//  LegueDetailsViewController.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 23/05/2024.
//

import UIKit

class LegueDetailsViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBAction func favBtn(_ sender: UIBarButtonItem) {
        
    }
    @IBOutlet weak var compCollectionView: UICollectionView!
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        compCollectionView.dataSource = self
        compCollectionView.delegate = self
        let upCompingCell = UINib(nibName: "UpComingEventsCollectionViewCell", bundle: nil)
        compCollectionView.register(upCompingCell, forCellWithReuseIdentifier: "upComingCell")
        let latestCell = UINib(nibName: "LatestEventCollectionViewCell", bundle: nil)
        compCollectionView.register(latestCell, forCellWithReuseIdentifier: "latestCell")
        let teamsCell = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)
        compCollectionView.register(teamsCell, forCellWithReuseIdentifier: "teamsCell")
        
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
                guard let self = self else { return nil }
                return self.drawSection(for: sectionIndex)
            }
            compCollectionView.setCollectionViewLayout(layout, animated: true)
        
        
        // Do any additional setup after loading the view.
    }
    
    func drawTheTopSection ()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
           // 5 create item
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
           
           // 4 group size
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(300))
           // 3 create group
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           
           // 2 create section
           let section = NSCollectionLayoutSection(group: group)
           section.orthogonalScrollingBehavior = .continuous
           section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
           section.visibleItemsInvalidationHandler = { (items, offset, environment) in
               items.forEach { item in
                   let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                   let minScale: CGFloat = 0.8
                   let maxScale: CGFloat = 1.2
                   let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                   item.transform = CGAffineTransform(scaleX: scale, y: scale)
               }
           }
           
           return section
    }
    func drawSectionTwo() -> NSCollectionLayoutSection {
        // Define item size
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(390), heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Define group size to account for item size and spacing
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(122)) // 120 (item height) + 2 (spacing)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        // Set group content insets to zero to ensure no extra spacing
        group.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Create section and set content insets
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }

    func drawSectionThere() -> NSCollectionLayoutSection {
        // Define item size
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
        
        // Create item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Define group size to match item size
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
        
        // Create group with one item per group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Set inter item spacing to zero
        group.interItemSpacing = .fixed(0)
        
        // Create section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        // Adjust content insets to zero for no spacing around the section
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // Adjust cell scaling
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.2
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return section
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func drawSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
        case 0:
            return drawTheTopSection()
        case 1:
            return drawSectionTwo()
        
        default:
            return drawSectionThere()
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
       
            switch indexPath.section {
            case 0:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingCell", for: indexPath)
            case 1:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestCell", for: indexPath)
            case 2:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath)
            default:
                fatalError("Invalid section")
            }
        cell.layer.cornerRadius = 25
            
            // Configure the cell
            
            return cell
    }
    

}
