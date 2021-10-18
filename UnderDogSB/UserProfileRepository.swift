//
//  UserProfile.swift
//  UnderDog Prototype
//
//  Created by John Lee on 4/3/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

//#if (arm64)
struct UserProfile: Codable {
  var uid: String
  var displayName: String
  var State: String
  var age: Int
  var email: String
  var score: [Double]
}

struct preference: Codable {
  var NFL: Bool
//  var AFL: Bool
  var MLB: Bool
  var NBA: Bool
  var NHL: Bool
  var NCAAF: Bool
//  var Euroleague: Bool
//  var MMA: Bool
//  var NRL: Bool
  var EPL: Bool
  var MLS: Bool
  var UEFA: Bool
  var SERIEA: Bool
  var LALIGA: Bool
}

class UserProfileRepository: ObservableObject {
  private var db = Firestore.firestore()

    func createProfile(profile: UserProfile, preference: preference, completion: @escaping (_ profile: UserProfile?, _ preference: preference? ,_ error: Error?) -> Void) {
        do {
            let _ = try db.collection("users").document(profile.uid).setData(from: profile)
            let _ = try db.collection("users").document(profile.uid).collection("preference").document("preference").setData(from: preference)
            completion(profile, preference, nil)
        }
        catch let error {
          print("Error writing users to Firestore: \(error)")
          completion(nil, nil, error)
        }
    }
    func fetchProfile(userId: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
        db.collection("users").document(userId).getDocument { (snapshot, error) in
          let profile = try? snapshot?.data(as: UserProfile.self)
          completion(profile, error)
        }
    }
    func listenProfile(userId: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
        db.collection("users").document(userId)
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
                guard let profile = try? document.data(as: UserProfile.self) else {
                    print("Error getting data: \(error)")
                    return
              }
              completion(profile, error)
            }
    }
    func fetchPref(userId: String, completion: @escaping (_ pref: preference?, _ error: Error?) -> Void) {
        db.collection("users").document(userId).collection("preference").document("preference").getDocument { (snapshot, error) in
            let pref = try? snapshot?.data(as: preference.self)
            completion(pref,error)
        }
    }
    func listenPref(userId: String, completion: @escaping (_ pref: preference?, _ error: Error?) -> Void) {
        db.collection("users").document(userId).collection("preference").document("preference").addSnapshotListener { documentSnapShot, error in
            guard let document = documentSnapShot else {
                print("Error getting preference: \(error)")
                return
            }
            let pref = try? document.data(as: preference.self)
            completion(pref, error)
        }
    }
    func updatePref(userId: String, NFL:Bool, MLB: Bool, NBA: Bool, NHL: Bool, NCAAF: Bool, EPL: Bool, MLS: Bool, SERIEA: Bool, LALIGA: Bool, UEFA: Bool, completion: @escaping (_ pref: preference?, _ error: Error?) -> Void) {
        db.collection("users").document(userId).collection("preference").document("preference").updateData([
            "NFL": NFL,
            "MLB": MLB,
            "NHL": NHL,
            "NBA": NBA,
            "NCAAF": NCAAF,
            "EPL": EPL,
            "MLS": MLS,
            "UEFA": UEFA,
            "LALIGA": LALIGA,
            "SERIEA": SERIEA,
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    func updateScore(userId: String ,NewScore: Double,completion: @escaping (_ Nscore: [Double] ,_ error: Error?) -> Void){
        let userReference = db.collection("users").document(userId)
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let userDocument: DocumentSnapshot
            do {
                try userDocument = transaction.getDocument(userReference)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }

            guard let oldscore = userDocument.data()?["score"] as? [Double] else {
                let error = NSError(
                    domain: "AppErrorDomain",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Unable to retrieve score from snapshot \(userDocument)"
                    ]
                )
                errorPointer?.pointee = error
                return nil
            }
            var score = oldscore
            score.append(NewScore)
//            print(score)
            transaction.updateData(["score": score], forDocument: userReference)
            return score
        }) { (object, error) in
            if let error = error {
                print("Error updating score: \(error)")
            } else {
                print("Score is updated \(object!)")
            }
        }
    }
}
//#endif
