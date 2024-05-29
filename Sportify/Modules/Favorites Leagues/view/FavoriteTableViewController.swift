//
//  FavoriteTableViewController.swift
//  Sportify
//
//  Created by aya on 25/05/2024.
//

import UIKit
import Reachability

class FavoriteTableViewController: UITableViewController {
    private var favoriteViewModel = FavoriteViewModel()
    var leguesDetailsViewModel = LeguesDetailsViewModel()
    var leagues: [LegueModel] = []
    private var noFavoritesImage: UIImageView?
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LeguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeguesTableViewCell")
        
        
        noFavoritesImage = UIImageView(image: UIImage(named: "noFav"))
        noFavoritesImage?.contentMode = .scaleAspectFit
        noFavoritesImage?.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(noFavoritesImage!)
        
        
        let centerXConstraint = noFavoritesImage?.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        let centerYConstraint = noFavoritesImage?.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        
        
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
        super.tableView(tableView, cellForRowAt: indexPath)
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
            let alert = UIAlertController(title: "Delete Favorite", message: "Are you sure you want to delete this favorite?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                let leagueToDelete = self.favoriteViewModel.leagues[indexPath.row]
                self.favoriteViewModel.leagues.remove(at: indexPath.row)
                self.favoriteViewModel.deleteLeague(league: leagueToDelete)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let reachability = try? Reachability()
        
        if reachability?.connection == .wifi || reachability?.connection == .cellular {
            if let leagueDetailsVC = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "LegueDetailsViewController") as? LegueDetailsViewController {
                leagueDetailsVC.modalPresentationStyle = .fullScreen
                leagueDetailsVC.league = favoriteViewModel.leagues[indexPath.row]
                present(leagueDetailsVC, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
}
