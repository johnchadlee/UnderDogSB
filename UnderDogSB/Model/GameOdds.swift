//
//  GameOdds.swift
//  UnderDog Prototype
//
//  Created by John Lee on 7/26/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

// MARK: - Datum
struct Match: Codable, Identifiable {
    let id: String
    let home_team: String
    let away_team: String
    let date: String
    let home_odd: Double
    let away_odd: Double
    let sports_key: String
}


class GameOddsRepo: ObservableObject {
    private var db = Firestore.firestore()
    
    func MLBUpComingGames(completion: @escaping (_ matches: [Match],_ error: Error?) -> Void) {
            var upcoming: [Match] = []
        
            db.collection("mlb_odds").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching: \(error)")
                    return
                }
                for document in querySnapshot!.documents {
                    let specificMatch = try? document.data(as: Match.self)
                    if specificMatch != nil {
                        upcoming.append(specificMatch!)
                    }
                }
//                print(upcoming)
                completion(upcoming, nil)
            }
    }
    func NBAUpComingGames(completion: @escaping (_ matches: [Match],_ error: Error?) -> Void) {
            var upcoming: [Match] = []
        
            db.collection("nba_odds").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching: \(error)")
                    return
                }
                for document in querySnapshot!.documents {
                    let specificMatch = try? document.data(as: Match.self)
                    if specificMatch != nil {
                        upcoming.append(specificMatch!)
                    }
                }
//                print(upcoming)
                completion(upcoming, nil)
            }
    }
    func NFLUpComingGames(completion: @escaping (_ matches: [Match],_ error: Error?) -> Void) {
            var upcoming: [Match] = []
        
            db.collection("nfl_odds").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching: \(error)")
                    return
                }
                for document in querySnapshot!.documents {
                    let specificMatch = try? document.data(as: Match.self)
                    if specificMatch != nil {
                        upcoming.append(specificMatch!)
                    }
                }
//                print(upcoming)
                completion(upcoming, nil)
            }
    }
    func NHLUpComingGames(completion: @escaping (_ matches: [Match],_ error: Error?) -> Void) {
            var upcoming: [Match] = []
        
            db.collection("nhl_odds").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching: \(error)")
                    return
                }
                for document in querySnapshot!.documents {
                    let specificMatch = try? document.data(as: Match.self)
                    if specificMatch != nil {
                        upcoming.append(specificMatch!)
                    }
                }
//                print(upcoming)
                completion(upcoming, nil)
            }
    }
    func NCAAFUpComingGames(completion: @escaping (_ matches: [Match],_ error: Error?) -> Void) {
            var upcoming: [Match] = []
        
            db.collection("ncaaf_odds").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching: \(error)")
                    return
                }
                for document in querySnapshot!.documents {
                    let specificMatch = try? document.data(as: Match.self)
                    if specificMatch != nil {
                        upcoming.append(specificMatch!)
                    }
                }
//                print(upcoming)
                completion(upcoming, nil)
            }
    }
    func MLSUpComingGames(completion: @escaping (_ matches: [Match],_ error: Error?) -> Void) {
            var upcoming: [Match] = []
        
            db.collection("mls_odds").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching: \(error)")
                    return
                }
                for document in querySnapshot!.documents {
                    let specificMatch = try? document.data(as: Match.self)
                    if specificMatch != nil {
                        upcoming.append(specificMatch!)
                    }
                }
//                print(upcoming)
                completion(upcoming, nil)
            }
    }
    func UEFAUpComingGames(completion: @escaping (_ matches: [Match],_ error: Error?) -> Void) {
            var upcoming: [Match] = []
        
            db.collection("UEFA_odds").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching: \(error)")
                    return
                }
                for document in querySnapshot!.documents {
                    let specificMatch = try? document.data(as: Match.self)
                    if specificMatch != nil {
                        upcoming.append(specificMatch!)
                    }
                }
//                print(upcoming)
                completion(upcoming, nil)
            }
    }
    func LaLigaUpComingGames(completion: @escaping (_ matches: [Match],_ error: Error?) -> Void) {
            var upcoming: [Match] = []
        
            db.collection("LaLiga_odds").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching: \(error)")
                    return
                }
                for document in querySnapshot!.documents {
                    let specificMatch = try? document.data(as: Match.self)
                    if specificMatch != nil {
                        upcoming.append(specificMatch!)
                    }
                }
//                print(upcoming)
                completion(upcoming, nil)
            }
    }
    func SerieAUpComingGames(completion: @escaping (_ matches: [Match],_ error: Error?) -> Void) {
            var upcoming: [Match] = []
        
            db.collection("SerieA_odds").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching: \(error)")
                    return
                }
                for document in querySnapshot!.documents {
                    let specificMatch = try? document.data(as: Match.self)
                    if specificMatch != nil {
                        upcoming.append(specificMatch!)
                    }
                }
//                print(upcoming)
                completion(upcoming, nil)
            }
    }
    func EPLUpComingGames(completion: @escaping (_ matches: [Match],_ error: Error?) -> Void) {
            var upcoming: [Match] = []
        
            db.collection("epl_odds").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching: \(error)")
                    return
                }
                for document in querySnapshot!.documents {
                    let specificMatch = try? document.data(as: Match.self)
                    if specificMatch != nil {
                        upcoming.append(specificMatch!)
                    }
                }
//                print(upcoming)
                completion(upcoming, nil)
            }
    }
}
