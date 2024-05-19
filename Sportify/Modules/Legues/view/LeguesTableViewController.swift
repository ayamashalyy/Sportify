//
//  LeguesTableViewController.swift
//  Sportify
//
//  Created by aya on 16/05/2024.
//

import UIKit
import Kingfisher
class LeguesTableViewController: UITableViewController {
    let testData = ["sport1","sports2","sports3","sports4"]
    var viewModel = LeguesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "LeguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeguesTableViewCell")
        bindViewModel()

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
        return testData.count
        //viewModel.leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeguesTableViewCell", for: indexPath) as! LeguesTableViewCell
       // let league = viewModel.leagues[indexPath.row]
        cell.legueLabel.text = testData[indexPath.row]
        //league.league_name
//        if let logoURL = league.league_logo, let url = URL(string: logoURL) {
//                    cell.legueImage.kf.setImage(with: url)
//                } else {
//                    cell.legueImage.image = UIImage(named: "1")
//                }
        cell.legueImage.image = UIImage(named: "1")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
    
}
