//
//  FavoriteTableViewController.swift
//  Sportify
//
//  Created by aya on 25/05/2024.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    private var favoriteViewModel = FavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "LeguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeguesTableViewCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeguesTableViewCell", for: indexPath) as! LeguesTableViewCell
        cell.legueImage.image = UIImage(named: "cup")
        cell.legueImage.layer.cornerRadius = cell.legueImage.frame.height / 2

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
