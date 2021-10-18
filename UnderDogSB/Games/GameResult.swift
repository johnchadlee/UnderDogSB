//
//  GameResult.swift
//  UnderDog Prototype
//
//  Created by John Lee on 7/20/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

//#if (arm64)
//struct NBAGameResult: Codable {
//    var away_score: String = ""
//    var away_team: String = ""
//    var date: String = ""
//    var full_name: String = ""
//    var home_score: String = ""
//    var home_team: String = ""
//    var period: Int = 0
//    var short_name: String = ""
//    var status: String = ""
//    var winner: String = ""
//}

struct GameResult: Codable {
    var away_odd: Double = 0.0
    var away_score: Int = 0
    var away_team: String = ""
    var date: String = ""
    var full_name: String = ""
    var home_odd: Double = 0.0
    var home_score: Int = 0
    var home_team: String = ""
    var id: String = ""
    var innings: Int = 0
    var short_name: String = ""
    var status: String = ""
    var winner: String = ""
}


class ResultRepository: ObservableObject {
    private var db = Firestore.firestore()
    
    func findFinishedMLBGames(completion: @escaping (_ result: [GameResult],_ error: Error?) -> Void) {
            var evaluateGames: [GameResult] = []
        
//            db.collection("MLB_new").whereField("status", isEqualTo: "Final").getDocuments() { (querySnapshot, err) in
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                    } else {
//                        for document in querySnapshot!.documents {
//                            let result = try? document.data(as: MLBGameResult.self)
//                            if result != nil{
//                                evaluateGames.append(result!)
//                            }
//                        }
//                    }
//                print(evaluateGames)
//                completion(evaluateGames, nil)
//            }
            db.collection("mlb_clean_data").whereField("status", isEqualTo: "Final").addSnapshotListener { querySnapshot, error in
                guard querySnapshot != nil else{
                    print("Error fetching mlbGames: \(error)")
                    return
                }
                for document in querySnapshot!.documents {
                    let result = try? document.data(as: GameResult.self)
                    
                    if result != nil {
                        evaluateGames.append(result!)
                    }
                }
                completion(evaluateGames, nil)
            }
    }
    func findFinishedNBAGames(completion: @escaping (_ result: [GameResult],_ error: Error?) -> Void) {
        var evaluateGames: [GameResult] = []
        db.collection("nba_clean_data").whereField("status", isEqualTo: "Final").addSnapshotListener { querySnapshot, error in
            guard querySnapshot != nil else{
                print("Error fetching mlbGames: \(error)")
                return
            }
            for document in querySnapshot!.documents {
                let result = try? document.data(as: GameResult.self)
                
                if result != nil {
                    evaluateGames.append(result!)
                }
            }
            completion(evaluateGames, nil)
        }
    }
    func findFinishedNCAAFGames(completion: @escaping (_ result: [GameResult],_ error: Error?) -> Void) {
        var evaluateGames: [GameResult] = []
        db.collection("ncaaf_clean_data").whereField("status", isEqualTo: "Final").addSnapshotListener { querySnapshot, error in
            guard querySnapshot != nil else{
                print("Error fetching mlbGames: \(error)")
                return
            }
            for document in querySnapshot!.documents {
                let result = try? document.data(as: GameResult.self)
                
                if result != nil {
                    evaluateGames.append(result!)
                }
            }
            completion(evaluateGames, nil)
        }
    }
    func findFinishedNHLGames(completion: @escaping (_ result: [GameResult],_ error: Error?) -> Void) {
        var evaluateGames: [GameResult] = []
        db.collection("nhl_clean_data").whereField("status", isEqualTo: "Final").addSnapshotListener { querySnapshot, error in
            guard querySnapshot != nil else{
                print("Error fetching mlbGames: \(error)")
                return
            }
            for document in querySnapshot!.documents {
                let result = try? document.data(as: GameResult.self)
                
                if result != nil {
                    evaluateGames.append(result!)
                }
            }
            completion(evaluateGames, nil)
        }
    }
    func findFinishedNFLGames(completion: @escaping (_ result: [GameResult],_ error: Error?) -> Void) {
        var evaluateGames: [GameResult] = []
        db.collection("nfl_clean_data").whereField("status", isEqualTo: "Final").addSnapshotListener { querySnapshot, error in
            guard querySnapshot != nil else{
                print("Error fetching mlbGames: \(error)")
                return
            }
            for document in querySnapshot!.documents {
                let result = try? document.data(as: GameResult.self)
                
                if result != nil {
                    evaluateGames.append(result!)
                }
            }
            completion(evaluateGames, nil)
        }
    }
}

//#endif
