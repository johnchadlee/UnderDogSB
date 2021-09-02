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
    
    func FindUpComingGames(completion: @escaping (_ matches: [Match],_ error: Error?) -> Void) {
            var upcoming: [Match] = []
            db.collection("MLBOdds").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching mlbGames: \(error)")
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
