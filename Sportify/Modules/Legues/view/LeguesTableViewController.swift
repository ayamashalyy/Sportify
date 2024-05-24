//
//  LeguesTableViewController.swift
//  Sportify
//
//  Created by aya on 16/05/2024.
//

import UIKit
import Kingfisher
class LeguesTableViewController: UITableViewController {
    var sportType : String?
    var viewModel = LeguesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "LeguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeguesTableViewCell")
        
        bindViewModel()
        print(viewModel.leagues.count)
        print(sportType ?? "no data")
        if let sportType = sportType {
          viewModel.fetchLeagues(for: sportType)
          }

    }
    private func bindViewModel() {
        viewModel.didUpdateLeagues = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.didFailWithError = { error in
                    print("Failed to fetch leagues: \(error.localizedDescription)")
                }
            }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeguesTableViewCell", for: indexPath) as! LeguesTableViewCell
        let league = viewModel.leagues[indexPath.row]
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

extension LeguesTableViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0)
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let legueDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "LegueDetailsViewController") as! LegueDetailsViewController
        legueDetailVC.modalPresentationStyle = .fullScreen
        let league = viewModel.leagues[indexPath.row]
        legueDetailVC.leagueId = league.league_key
        self.present(legueDetailVC, animated: true)
    }
}
