//
//  FavoriteTableViewController.swift
//  Sportify
//
//  Created by aya on 25/05/2024.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    private var favoriteViewModel = FavoriteViewModel()
    private var leagues: [LegueModel] = []
    private var noFavoritesImage: UIImageView?
    override func viewDidLoad() {
        tableView.delegate = self
           tableView.dataSource = self
           tableView.register(UINib(nibName: "LeguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeguesTableViewCell")

           // Create the "no favorites" image
           noFavoritesImage = UIImageView(image: UIImage(named: "noFav"))
           noFavoritesImage?.contentMode = .scaleAspectFit
           noFavoritesImage?.translatesAutoresizingMaskIntoConstraints = false
           tableView.addSubview(noFavoritesImage!)

           // Add constraints to center the image vertically and horizontally
           let centerXConstraint = noFavoritesImage?.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
           let centerYConstraint = noFavoritesImage?.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)

           // Add constraints to set the size of the image
           let widthConstraint = noFavoritesImage?.widthAnchor.constraint(equalToConstant: 300)
           let heightConstraint = noFavoritesImage?.heightAnchor.constraint(equalToConstant: 300)

           if let centerXConstraint = centerXConstraint,
              let centerYConstraint = centerYConstraint,
              let widthConstraint = widthConstraint,
              let heightConstraint = heightConstraint {
               NSLayoutConstraint.activate([centerXConstraint, centerYConstraint, widthConstraint, heightConstraint])
           }
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
        noFavoritesImage?.isHidden = favoriteViewModel.leagues.count > 0
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
        noFavoritesImage?.isHidden = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let leagueToDelete = favoriteViewModel.leagues[indexPath.row]
            favoriteViewModel.leagues.remove(at: indexPath.row)
            favoriteViewModel.deleteLeague(league: leagueToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
