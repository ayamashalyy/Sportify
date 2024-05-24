//
//  DataBaseManager.swift
//  Sportify
//
//  Created by aya on 23/05/2024.
//

import Foundation
import CoreData
import UIKit





protocol FavoriteProtocol : AnyObject{
    func insertLeague(league: LegueModel)
    func getAllLeagues()->[LegueModel]
    func deleteLeagueItem(league: LegueModel)
}

class DataBaseManager : FavoriteProtocol {
    func insertLeague(league: LegueModel) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        print("test")
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Leagues", in: managedContext)
        let myLeague = NSManagedObject(entity: entity!, insertInto: managedContext)
        myLeague.setValue(league.league_key, forKey: "league_key")
        myLeague.setValue(league.league_name, forKey: "league_name")
        myLeague.setValue(league.league_logo, forKey: "league_logo")
        do {
            try managedContext.save()
        }catch let error as NSError{
            print(error)
        }
    }
    
    func getAllLeagues() -> [LegueModel] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Leagues")
        do {
            let results = try managedContext.fetch(fetchRequest)
            var leagues: [LegueModel] = []
            
            for data in results as! [NSManagedObject] {
                if let leagueKey = data.value(forKey: "league_key") as? Int,
                   let leagueName = data.value(forKey: "league_name") as? String,
                   let leagueLogo = data.value(forKey: "league_logo") as? String? {
                    let league = LegueModel(league_key: leagueKey, league_name: leagueName, league_logo: leagueLogo)
                    leagues.append(league)
                }
            }
            
            return leagues
        } catch let error as NSError {
            print("Error fetching leagues: \(error), \(error.userInfo)")
            return []
        }
    }
    
    func deleteLeagueItem(league: LegueModel) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
