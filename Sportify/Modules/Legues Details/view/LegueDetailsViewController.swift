//
//  LegueDetailsViewController.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 23/05/2024.
//

import UIKit

class LegueDetailsViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    var legueDetailsViewModel = LeguesDetailsViewModel()
    var leagueId : Int?
    
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
            return self.drawSections(for: sectionIndex)
        }
        compCollectionView.setCollectionViewLayout(layout, animated: true)
        
        bindViewModel()
//        print(legueDetailsViewModel.legueDetails.count)
//        print(leagueId ?? "no data")
        if let leagueId = leagueId {
            legueDetailsViewModel.fetchUpComingEventsLegueDetails(for: leagueId)
            legueDetailsViewModel.fetchLastestEventsLegueDetails(for: leagueId)
            legueDetailsViewModel.fetchTeams(for: leagueId)
          }
    }
    private func bindViewModel() {
        legueDetailsViewModel.didUpdateLegueDetail = { [weak self] in
            DispatchQueue.main.async {
                self?.compCollectionView.reloadData()
            }
        }
        legueDetailsViewModel.didFailWithError = { error in
                    print("Failed to fetch leagues: \(error.localizedDescription)")
                }
            }
    
    func drawUpComingEventsCell ()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 50)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 35, bottom: 0, trailing: 50)
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
    func drawLatestEventsCell() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(360), heightDimension: .absolute(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)) // 120
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 6, bottom: 20, trailing: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 20, trailing: 2)
        
        return section
    }
    
    func drawTeamsSectionCell() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 0)
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
    
    func drawSections(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
        case 0:
            return drawUpComingEventsCell()
        case 1:
            return drawLatestEventsCell()
            
        default:
            return drawTeamsSectionCell()
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return legueDetailsViewModel.legueDetails.count
        case 2:
            return legueDetailsViewModel.teamData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teamData = legueDetailsViewModel.teamData[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? TeamsCollectionViewCell {
            if let teamDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController {
                teamDetailsVC.team_key = teamData.team_key
                teamDetailsVC.modalPresentationStyle = .fullScreen
                present(teamDetailsVC, animated: true, completion: nil)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row < legueDetailsViewModel.legueDetails.count {
                let leagueDetails = legueDetailsViewModel.legueDetails[indexPath.row]
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingCell", for: indexPath) as! UpComingEventsCollectionViewCell
                cell.eventName.text = leagueDetails.league_name
                cell.eventTime.text = leagueDetails.event_time
                cell.eventDate.text = leagueDetails.event_date
                cell.team1_name.text = leagueDetails.event_home_team
                cell.team2_name.text = leagueDetails.event_away_team
                if let imageUrlOfTeam1 = leagueDetails.home_team_logo, let urlLogo1 = URL(string: imageUrlOfTeam1) {
                    cell.team1_logo.kf.setImage(with: urlLogo1)
                } else {
                    cell.team1_logo.image = UIImage(named: "cup.jpeg")
                }
                if let imageUrlOfTeam2 = leagueDetails.away_team_logo, let urlLogo2 = URL(string: imageUrlOfTeam2) {
                    cell.team2_logo.kf.setImage(with: urlLogo2)
                } else {
                    cell.team2_logo.image = UIImage(named: "cup.jpeg")
                }
                cell.layer.cornerRadius = 25
                return cell
            }
        case 1:
            if indexPath.row < legueDetailsViewModel.legueDetails.count {
                let leagueDetails = legueDetailsViewModel.legueDetails[indexPath.row]
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestCell", for: indexPath) as! LatestEventCollectionViewCell
                cell.timeLatestEvent.text = leagueDetails.event_time
                cell.dateLatestEvent.text = leagueDetails.event_date
                cell.team1Name.text = leagueDetails.event_home_team
                cell.team2Name.text = leagueDetails.event_away_team
                if let imageUrlOfTeam1 = leagueDetails.home_team_logo, let urlLogo1 = URL(string: imageUrlOfTeam1) {
                    cell.team1Logo.kf.setImage(with: urlLogo1)
                } else {
                    cell.team1Logo.image = UIImage(named: "cup.jpeg")
                }
                if let imageUrlOfTeam2 = leagueDetails.away_team_logo, let urlLogo2 = URL(string: imageUrlOfTeam2) {
                    cell.team2Logo.kf.setImage(with: urlLogo2)
                } else {
                    cell.team2Logo.image = UIImage(named: "cup.jpeg")
                }
                cell.score.text = leagueDetails.event_final_result
        
                return cell
            }
        case 2:
            if indexPath.row < legueDetailsViewModel.teamData.count {
                let teamData = legueDetailsViewModel.teamData[indexPath.row]
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCollectionViewCell
                cell.teamName.text = teamData.team_name
                if let imageUrlOfTeam = teamData.team_logo, let urlLogo = URL(string: imageUrlOfTeam) {
                    cell.teamLogo.kf.setImage(with: urlLogo)
                } else {
                    cell.teamLogo.image = UIImage(named: "cup.jpeg")
                }
                cell.layer.cornerRadius = 25
               
                return cell
            }
        default:
            fatalError("Invalid section")
        }

        return UICollectionViewCell()
    }
    
}


