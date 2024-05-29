//
//  LegueDetailsViewController.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 23/05/2024.
//

import UIKit

class LegueDetailsViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var legueDetailsViewModel = LeguesDetailsViewModel()
    var leagueId : Int?
    var league: LegueModel?
    var sportType: String?
    @IBOutlet weak var favButton: UIBarButtonItem!
    @IBAction func favBtn(_ sender: UIBarButtonItem) {
        guard let league = league else {
            print("No league model available to insert")
            return
        }
        if isFav() {
            legueDetailsViewModel.removeLeagueFromFavorites(league: league)
            favButton.image = UIImage(named : "8")
        } else {
            legueDetailsViewModel.addLeagueToFavorites(league: league)
            favButton.image = UIImage(named : "9")
            
        }
        
    }
    
    
    func isFav() -> Bool {
        var isFavorite: Bool = false
        let leagues = legueDetailsViewModel.getLeagues()
        for le in leagues {
            if league?.league_key == le.league_key{
                isFavorite = true
                favButton.image = UIImage(named : "9")
                break
            }
        }
        return isFavorite
    }
    
    
    
    @IBOutlet weak var compCollectionView: UICollectionView!
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerViewNib = UINib(nibName: "CollectionReusableView", bundle: nil)
        compCollectionView.register(headerViewNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        let emptyStateCell = UINib(nibName: "EmptyStateCollectionViewCell", bundle: nil)
        compCollectionView.register(emptyStateCell, forCellWithReuseIdentifier: "emptyStateCell")
        isFav()
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
        if let league = league {
            legueDetailsViewModel.fetchUpComingEventsLegueDetails(for: league.league_key!,sportType: league.sportType!)
            legueDetailsViewModel.fetchLastestEventsLegueDetails(for: league.league_key!,sportType: league.sportType!)
            legueDetailsViewModel.fetchTeams(for: league.league_key!) { result in
                switch result {
                case .success:
                    print("Teams fetched successfully")
                case .failure(let error):
                    print("Failed to fetch teams: \(error.localizedDescription)")
                }
            }
            
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
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 17, bottom: 8, trailing: 50)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 35, bottom: 0, trailing: 50)
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 20, trailing: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 20, trailing: 2)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
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
            return legueDetailsViewModel.legueDetails.isEmpty ? 1 : legueDetailsViewModel.legueDetails.count
        case 2:
            return legueDetailsViewModel.teamData.isEmpty ? 1 : legueDetailsViewModel.teamData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (indexPath.section == 2){
            let teamData = legueDetailsViewModel.teamData[indexPath.row]
            if let cell = collectionView.cellForItem(at: indexPath) as? TeamsCollectionViewCell {
                if let teamDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController {
                    teamDetailsVC.team_key = teamData.team_key
                    teamDetailsVC.modalPresentationStyle = .fullScreen
                    present(teamDetailsVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0:
            if legueDetailsViewModel.legueDetails.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyStateCell", for: indexPath) as! EmptyStateCollectionViewCell
                cell.emptyImage.image = UIImage(named: "noEvent")
                return cell
            } else {
                if indexPath.row < legueDetailsViewModel.legueDetails.count {
                    let leagueDetails = legueDetailsViewModel.legueDetails[indexPath.row]
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingCell", for: indexPath) as! UpComingEventsCollectionViewCell
                    cell.eventName.text = leagueDetails.league_name
                    cell.eventTime.text = leagueDetails.event_time
                    let eventDateFormatter = DateFormatter()
                    eventDateFormatter.dateFormat = "yyyy-MM-dd"
                    let eventDate = eventDateFormatter.date(from: leagueDetails.event_date!)!
                    let calendar = Calendar.current
                    let day = calendar.component(.day, from: eventDate)
                    let monthNames = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
                    let month = calendar.component(.month, from: eventDate)
                    let eventDateString = "\(day) \(monthNames[month - 1])"
                    cell.eventDate.text = eventDateString
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
            }
            
        case 1:
            if legueDetailsViewModel.legueDetails.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyStateCell", for: indexPath) as! EmptyStateCollectionViewCell
                cell.emptyImage.image = UIImage(named: "noEvent")
                return cell
            } else {
                if indexPath.row < legueDetailsViewModel.legueDetails.count {
                    let leagueDetails = legueDetailsViewModel.legueDetails[indexPath.row]
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestCell", for: indexPath) as! LatestEventCollectionViewCell
                    cell.timeLatestEvent.text = leagueDetails.event_time
                    let eventDateFormatter = DateFormatter()
                    eventDateFormatter.dateFormat = "yyyy-MM-dd"
                    let eventDate = eventDateFormatter.date(from: leagueDetails.event_date!)!
                    let calendar = Calendar.current
                    let day = calendar.component(.day, from: eventDate)
                    let monthNames = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
                    let month = calendar.component(.month, from: eventDate)
                    let eventDateString = "\(day) \(monthNames[month - 1])"
                    cell.dateLatestEvent.text = eventDateString
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
                    
                    
                    
                    cell.layer.cornerRadius = 25
                    
                    return cell
                }
            }
        case 2:
            if legueDetailsViewModel.teamData.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyStateCell", for: indexPath) as! EmptyStateCollectionViewCell
                cell.emptyImage.image = UIImage(named: "noTeam")
                return cell
            } else {
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
            }
        default:
            fatalError("Invalid section")
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! CollectionReusableView
            switch indexPath.section {
            case 0:
                headerView.titleLabel.text = "Upcoming Events"
            case 1:
                headerView.titleLabel.text = "Latest Events"
            case 2:
                headerView.titleLabel.text = "Teams"
            default:
                headerView.titleLabel.text = ""
            }
            return headerView
        }
        fatalError("Unexpected element kind")
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
}


