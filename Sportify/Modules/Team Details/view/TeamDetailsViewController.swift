//
//  TeamDetailsViewController.swift
//  Sportify
//
//  Created by aya on 22/05/2024.
//

import UIKit

import UIKit

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       tableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
        cell.playerImage?.image = UIImage(named:"1" )
       // cell.playerName?.text = "Aya"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
}
