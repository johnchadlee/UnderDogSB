//
//  OrderDetails.swift
//  UnderDog Prototype
//
//  Created by John Lee on 5/17/21.

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct OrderDetails: Codable, Identifiable {
  var id: String = ""
  var time: String = ""
  var team_Name1: String = ""
  var team_Name2: String = ""
  var SelectedOdd: Double = 0
  var ExpectedEarning: Double = 0
  var value: String = ""
  var purchase: String = ""
  var homeTeam: String = ""
  var gameID: String = ""
}

class OrderRepository: ObservableObject {
    private var db = Firestore.firestore()
    
    func createOrder(userId: String,order: OrderDetails, completion: @escaping (_ order: OrderDetails?,_ error: Error?) -> Void) {
        do {
            let _ = try db.collection("users").document(userId).collection("On Going Bet").document(order.id).setData(from: order)
            completion(order, nil)
        }
        catch let error {
          print("Error writing users to Firestore: \(error)")
          completion(nil, error)
        }
    }
    func WonOrder(userId: String,order: OrderDetails, completion: @escaping (_ order: OrderDetails?,_ error: Error?) -> Void) {
        do {
            let _ = try db.collection("users").document(userId).collection("Bets Won").document(order.id).setData(from: order)
            completion(order, nil)
        }
        catch let error {
          print("Error writing users to Firestore: \(error)")
          completion(nil, error)
        }
    }
    func fetchWonBets(userId: String, completion: @escaping ( _ allBetsWon: [OrderDetails]?, _ error: Error?) -> Void) {
        db.collection("users").document(userId).collection("Bets Won").getDocuments() { (querySnapshot, err) in
        var allBetsWon: [OrderDetails] = []
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
                let order = try? document.data(as: OrderDetails.self)
                if order != nil {
                    allBetsWon.append(order!)
                }
            }
        }
          completion(allBetsWon, err)
        }


        db.collection("users").document(userId).collection("Bets Won").addSnapshotListener { querySnapshot, error in
            var allBetsWon: [OrderDetails] = []
            guard querySnapshot != nil else {
                    print("Error fetching Bets Won: \(error!)")
                    return
                }
                for document in querySnapshot!.documents {
                    let order = try? document.data(as: OrderDetails.self)
                    if order != nil{
                        allBetsWon.append(order!)
                    }
                }
                completion(allBetsWon, error)
        }
    }
    func LostOrder(userId: String,order: OrderDetails, completion: @escaping (_ order: OrderDetails?,_ error: Error?) -> Void) {
        do {
            let _ = try db.collection("users").document(userId).collection("Bets Lost").document(order.id).setData(from: order)
            completion(order, nil)
        }
        catch let error {
          print("Error writing users to Firestore: \(error)")
          completion(nil, error)
        }
    }
    func fetchLostBets(userId: String, completion: @escaping ( _ allBetsLost: [OrderDetails]?, _ error: Error?) -> Void) {
        db.collection("users").document(userId).collection("Bets Lost").getDocuments() { (querySnapshot, err) in
        var allBetsLost: [OrderDetails] = []
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
                let order = try? document.data(as: OrderDetails.self)
                if order != nil{
                    allBetsLost.append(order!)
                }
            }
        }
          completion(allBetsLost, err)
        }


        db.collection("users").document(userId).collection("Bets Lost").addSnapshotListener { querySnapshot, error in
            var allBetsLost: [OrderDetails] = []
            guard querySnapshot != nil else {
                    print("Error fetching onGoingBets: \(error!)")
                    return
                }
            for document in querySnapshot!.documents {
                    let order = try? document.data(as: OrderDetails.self)
                    if order != nil {
                        allBetsLost.append(order!)
                    }
            }
            completion(allBetsLost, error)
        }
    }
    func fetchOrder(userId: String, completion: @escaping ( _ OnGoingBets: [OrderDetails]?, _ error: Error?) -> Void) {
        db.collection("users").document(userId).collection("On Going Bet").getDocuments() { (querySnapshot, err) in
        var OnGoingBets: [OrderDetails] = []
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
                let order = try? document.data(as: OrderDetails.self)
                OnGoingBets.append(order!)
            }
        }
          completion(OnGoingBets, err)
        }
    }
    func listenOrder(userId: String, completion: @escaping (_ OnGoingBets: [OrderDetails]?, _ error: Error?) -> Void) {
        db.collection("users").document(userId).collection("On Going Bet").addSnapshotListener { querySnapshot, error in
                var OnGoingBets: [OrderDetails] = []
            guard querySnapshot != nil else {
                    print("Error fetching onGoingBets: \(error!)")
                    return
                }
                for document in querySnapshot!.documents {
                    let order = try? document.data(as: OrderDetails.self)
                    if(order == nil){
                        return;
                    }
                    OnGoingBets.append(order!)
                }
                completion(OnGoingBets, error)
            }
    }
    //Delete ongoing bet if game has ended and add to order history win/lost
    func deleteOrder(userId: String, orderID: String) {
        db.collection("users").document(userId).collection("On Going Bet").document(orderID).delete()
    }
}
