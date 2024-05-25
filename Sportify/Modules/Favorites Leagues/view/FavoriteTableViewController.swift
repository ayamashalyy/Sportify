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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteViewModel.fetchLeaguesFromDB()
        bindViewModel()
    }
    
    
    private func bindViewModel() {
        favoriteViewModel.leaguesDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteViewModel.leagues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeguesTableViewCell", for: indexPath) as! LeguesTableViewCell
        let league = favoriteViewModel.leagues[indexPath.row]
        cell.legueLabel.text = league.league_name
        if let logoURL = league.league_logo, let url = URL(string: logoURL) {
            cell.legueImage.kf.setImage(with: url)
            cell.legueImage.layer.cornerRadius = cell.legueImage.frame.height / 2
        } else {
            cell.legueImage.image = UIImage(named: "cup")
            cell.legueImage.layer.cornerRadius = cell.legueImage.frame.height / 2
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
