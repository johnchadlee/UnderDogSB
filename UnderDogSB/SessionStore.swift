//
//  SessionStore.swift
//  UnderDog Prototype
//
//  Created by John Lee on 3/11/21.
//

import SwiftUI
import Firebase
import Combine
import Foundation

//#if (arm64)
class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? {didSet {self.didChange.send(self) }}
    @Published var profile: UserProfile?
    @Published var pref: preference?
    @Published var order: OrderDetails?
    @Published var isDarkMode = false
    @Published var onGoingBets: [OrderDetails] = []
    @Published var WBets: OrderDetails?
    @Published var LBets: OrderDetails?
    @Published var wonBets: [OrderDetails] = []
    @Published var lostBets: [OrderDetails] = []
    @Published var gameResults: [GameResult] = []
    @Published var GameMatch: [Match] = []
    @Published var NFLGames: [Match] = []
    @Published var NBAGames: [Match] = []
    @Published var NCAAFGames: [Match] = []
    @Published var NHLGames: [Match] = []
    @Published var MLBGames: [Match] = []
    @Published var MLSGames: [Match] = []
    @Published var EPLGames: [Match] = []
    @Published var SerieAGames: [Match] = []
    @Published var UEFAGames: [Match] = []
    @Published var LaLigaGames: [Match] = []
    private var upcomingGameRepo = GameOddsRepo()
    private var profileRepository = UserProfileRepository()
    private var orderRespository = OrderRepository()
    private var resultRespository = ResultRepository()
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, email: user.email, displayName: user.displayName)
                self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
                  if let error = error {
                    print("Error while fetching the user profile: \(error)")
                    return
                  }
                  self.profile = profile
                }
                self.profileRepository.listenPref(userId: user.uid) { (pref, error) in
                  if let error = error {
                    print("Error while fetching the user profile: \(error)")
                    return
                  }
                  self.pref = pref
                    //Add Upcoming Games based on pref
                    if(self.pref?.MLB == true){
                        self.upcomingGameRepo.MLBUpComingGames() {
                            (gameMatch ,error) in
                            if let error = error{
                                print("\(error)")
                                return
                            }
                            self.GameMatch += gameMatch
                        }
                    }
                    if(self.pref?.NBA == true){
                        self.upcomingGameRepo.NBAUpComingGames() {
                            (gameMatch ,error) in
                            if let error = error{
                                print("\(error)")
                                return
                            }
                            self.GameMatch += gameMatch
                        }
                    }
                    if(self.pref?.NFL == true){
                        self.upcomingGameRepo.NFLUpComingGames() {
                            (gameMatch ,error) in
                            if let error = error{
                                print("\(error)")
                                return
                            }
                            self.GameMatch += gameMatch
                        }
                    }
                    if(self.pref?.NHL == true){
                        self.upcomingGameRepo.NHLUpComingGames() {
                            (gameMatch ,error) in
                            if let error = error{
                                print("\(error)")
                                return
                            }
                            self.GameMatch += gameMatch
                        }
                    }
                    if(self.pref?.NCAAF == true){
                        self.upcomingGameRepo.NCAAFUpComingGames() {
                            (gameMatch ,error) in
                            if let error = error{
                                print("\(error)")
                                return
                            }
                            self.GameMatch += gameMatch
                        }
                    }
                    if(self.pref?.MLS == true){
                        self.upcomingGameRepo.MLSUpComingGames() {
                            (gameMatch ,error) in
                            if let error = error{
                                print("\(error)")
                                return
                            }
                            self.GameMatch += gameMatch
                        }
                    }
                    if(self.pref?.UEFA == true){
                        self.upcomingGameRepo.UEFAUpComingGames() {
                            (gameMatch ,error) in
                            if let error = error{
                                print("\(error)")
                                return
                            }
                            self.GameMatch += gameMatch
                        }
                    }
                    if(self.pref?.LALIGA == true){
                        self.upcomingGameRepo.LaLigaUpComingGames() {
                            (gameMatch ,error) in
                            if let error = error{
                                print("\(error)")
                                return
                            }
                            self.GameMatch += gameMatch
                        }
                    }
                    if(self.pref?.SERIEA == true){
                        self.upcomingGameRepo.SerieAUpComingGames() {
                            (gameMatch ,error) in
                            if let error = error{
                                print("\(error)")
                                return
                            }
                            self.GameMatch += gameMatch
                        }
                    }
                    if(self.pref?.EPL == true){
                        self.upcomingGameRepo.EPLUpComingGames() {
                            (gameMatch ,error) in
                            if let error = error{
                                print("\(error)")
                                return
                            }
                            self.GameMatch += gameMatch
                        }
                    }
                    //Delete upcoming game based on pref
                    if(self.pref?.MLB == false && self.GameMatch.count != 0){
                        self.GameMatch.removeAll{
                            $0.sports_key == "baseball_mlb"
                        }
                    }
                    if(self.pref?.NCAAF == false && self.GameMatch.count != 0){
                        self.GameMatch.removeAll{
                            $0.sports_key == "americanfootball_ncaaf"
                        }
                    }
                    if(self.pref?.NHL == false && self.GameMatch.count != 0){
                        self.GameMatch.removeAll{
                            $0.sports_key == "icehockey_nhl"
                        }
                    }
                    if(self.pref?.NFL == false && self.GameMatch.count != 0){
                        self.GameMatch.removeAll{
                            $0.sports_key == "americanfootball_nfl"
                        }
                    }
                    if(self.pref?.NBA == false && self.GameMatch.count != 0){
                        self.GameMatch.removeAll{
                            $0.sports_key == "basketball_nba"
                        }
                    }
                    if(self.pref?.EPL == false && self.GameMatch.count != 0){
                        self.GameMatch.removeAll{
                            $0.sports_key == "soccer_epl"
                        }
                    }
                    if(self.pref?.UEFA == false && self.GameMatch.count != 0){
                        self.GameMatch.removeAll{
                            $0.sports_key == "soccer_uefa_champs_league"
                        }
                    }
                    if(self.pref?.LALIGA == false && self.GameMatch.count != 0){
                        self.GameMatch.removeAll{
                            $0.sports_key == "soccer_spain_la_liga"
                        }
                    }
                    if(self.pref?.SERIEA == false && self.GameMatch.count != 0){
                        self.GameMatch.removeAll{
                            $0.sports_key == "soccer_italy_serie_a"
                        }
                    }
                    if(self.pref?.MLS == false && self.GameMatch.count != 0){
                        self.GameMatch.removeAll{
                            $0.sports_key == "soccer_usa_mls"
                        }
                    }
                }
                self.orderRespository.listenOrder(userId: user.uid) { (onGoingBets, error) in
                  if let error = error {
                    print("Error while fetching order: \(error)")
                    return
                  }
                  self.onGoingBets = onGoingBets!
                  //Testing for immediate payout
                  self.PayOutFunction(userId: user.uid)
                }
                //Get games that are completed
                self.resultRespository.findFinishedNFLGames() { (gameResults , error) in
                    if let error = error {
                        print("Error finding finished games: \(error)")
                        return
                    }
                    self.gameResults += gameResults
//                    self.PayOutFunction(userId: user.uid)
                }
                self.resultRespository.findFinishedMLBGames() { (gameResults , error) in
                    if let error = error {
                        print("Error finding finished games: \(error)")
                        return
                    }
                    self.gameResults += gameResults
//                    self.PayOutFunction(userId: user.uid)
                }
                self.resultRespository.findFinishedNBAGames() { (gameResults , error) in
                    if let error = error {
                        print("Error finding finished games: \(error)")
                        return
                    }
                    self.gameResults += gameResults
//                    self.PayOutFunction(userId: user.uid)
                }
                self.resultRespository.findFinishedNCAAFGames() { (gameResults , error) in
                    if let error = error {
                        print("Error finding finished games: \(error)")
                        return
                    }
                    self.gameResults += gameResults
//                    self.PayOutFunction(userId: user.uid)
                }
                self.resultRespository.findFinishedNHLGames() { (gameResults , error) in
                    if let error = error {
                        print("Error finding finished games: \(error)")
                        return
                    }
                    self.gameResults += gameResults
//                    self.PayOutFunction(userId: user.uid)
                }
                //Payout base on OngoingBets and Results
                self.PayOutFunction(userId: user.uid)
                self.profileRepository.listenProfile(userId: user.uid) { (profile, error) in
                  if let error = error {
                    print("Error while fetching the user profile: \(error)")
                    return
                  }
                  self.profile = profile
                }
                //Betting history update in listen handler
                self.orderRespository.fetchLostBets(userId: user.uid) { (lbets ,error) in
                    if let error = error {
                        print("\(error)")
                        return
                    }
                    self.lostBets = lbets!
                }
                self.orderRespository.fetchWonBets(userId: user.uid) { (wbets ,error) in
                    if let error = error {
                        print("\(error)")
                        return
                    }
                    self.wonBets = wbets!
                }
            } else {
                self.session = nil
            }
        })
    }
    
    func getNFLGames(){
        self.upcomingGameRepo.NFLUpComingGames() {
            (gameMatch ,error) in
            if let error = error{
                print("\(error)")
                return
            }
            self.NFLGames = gameMatch;
        }
    }
    func getMLBGames(){
        self.upcomingGameRepo.MLBUpComingGames() {
            (gameMatch ,error) in
            if let error = error{
                print("\(error)")
                return
            }
            self.MLBGames = gameMatch;
        }
    }
    func getNCAAFGames(){
        self.upcomingGameRepo.NCAAFUpComingGames() {
            (gameMatch ,error) in
            if let error = error{
                print("\(error)")
                return
            }
            self.NCAAFGames = gameMatch;
        }
    }
    func getNHLGames(){
        self.upcomingGameRepo.NHLUpComingGames() {
            (gameMatch ,error) in
            if let error = error{
                print("\(error)")
                return
            }
            self.NHLGames = gameMatch;
        }
    }
    func getNBAGames(){
        self.upcomingGameRepo.NBAUpComingGames() {
            (gameMatch ,error) in
            if let error = error{
                print("\(error)")
                return
            }
            self.NBAGames = gameMatch;
        }
    }
    func getEPLGames(){
        self.upcomingGameRepo.EPLUpComingGames() {
            (gameMatch ,error) in
            if let error = error{
                print("\(error)")
                return
            }
            self.EPLGames = gameMatch;
        }
    }
    func getSerieAGames(){
        self.upcomingGameRepo.SerieAUpComingGames() {
            (gameMatch ,error) in
            if let error = error{
                print("\(error)")
                return
            }
            self.SerieAGames = gameMatch;
        }
    }
    func getMLSGames(){
        self.upcomingGameRepo.MLSUpComingGames() {
            (gameMatch ,error) in
            if let error = error{
                print("\(error)")
                return
            }
            self.MLSGames = gameMatch;
        }
    }
    func getUEFAGames(){
        self.upcomingGameRepo.UEFAUpComingGames() {
            (gameMatch ,error) in
            if let error = error{
                print("\(error)")
                return
            }
            self.UEFAGames = gameMatch;
        }
    }
    func getLaLigaGames(){
        self.upcomingGameRepo.LaLigaUpComingGames() {
            (gameMatch ,error) in
            if let error = error{
                print("\(error)")
                return
            }
            self.LaLigaGames = gameMatch;
        }
    }
    func PayOutFunction(userId: String) {
//        print(onGoingBets)
        if(onGoingBets.count > 0){
            onGoingBets.forEach {
                child in
//                print(mlbgameResults)
                gameResults.forEach {
                    game in
//                    print(game)
                    if (child.gameID == game.id){
                        if child.purchase == game.winner {
                            //Update Win Score
                            let currentScoreIndex = (profile?.score.count ?? 0 ) - 1
                            let PrevScore = profile?.score[currentScoreIndex]
                            let UpdateScore = (PrevScore ?? 0.0) + (child.ExpectedEarning)
                            self.profileRepository.updateScore(userId: userId, NewScore: UpdateScore) { (UpdatedScore, error) in
                                if let error = error {
                                    print("Error while updating score: \(error)")
                                    return
                                }
                            }
                            //Update Betting History
                            self.orderRespository.WonOrder(userId: userId, order: child) { (betsWon, error) in
                                if let error = error {
                                  print("Error while fetching the user profile: \(error)")
                                  return
                                }
                                self.WBets = betsWon
                            }
                            //Delete onGoing Bets
                            self.orderRespository.deleteOrder(userId: userId, orderID: child.id)
                            
                        }
                        else {
                            //Update Lose Score
                            let currentScoreIndex = (profile?.score.count ?? 0 ) - 1
                            let PrevScore = profile?.score[currentScoreIndex]
                            let UpdateScore = (PrevScore ?? 0.0) - (Double(child.value) ?? 0.0 )
                            self.profileRepository.updateScore(userId: userId,NewScore: UpdateScore) { (UpdatedScore, error) in
                                if let error = error {
                                    print("Error while updating score: \(error)")
                                    return
                                }
                            }
                            //Update Betting History
                            self.orderRespository.LostOrder(userId: userId, order: child) { (LostBets, error) in
                                if let error = error {
                                  print("Error while fetching the user profile: \(error)")
                                  return
                                }
                                self.LBets = LostBets
                            }
                            self.orderRespository.deleteOrder(userId: userId, orderID: child.id)
                        }
                    }
                }
            }
        }
    }
    func signUp(email: String, password: String, displayName: String ,State: String, age: Int, score: [Double], NFL: Bool, MLB: Bool, NBA: Bool, NHL: Bool, NCAAF: Bool, EPL: Bool, MLS: Bool, SERIEA: Bool, LALIGA: Bool, UEFA: Bool, completion: @escaping (_ profile: UserProfile?,_ pref: preference? ,_ error: Error?) -> Void) {
      Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
        if let error = error {
          print("Error signing up: \(error)")
          completion(nil, nil, error)
          return
        }
        guard let user = result?.user else { return }
        print("User \(user.uid) signed up.")

        let userProfile = UserProfile(uid: user.uid, displayName: displayName, State: State, age: age, email: email, score: score)
        let pref = preference(NFL: NFL, MLB: MLB, NBA: NBA, NHL: NHL, NCAAF: NCAAF, EPL: EPL, MLS: MLS, UEFA: UEFA, SERIEA: SERIEA, LALIGA: LALIGA)
        self.profileRepository.createProfile(profile: userProfile, preference: pref) { (profile, preference, error) in
          if let error = error {
            print("Error while creating the user profile: \(error)")
            completion(nil, nil, error)
            return
          }
          self.profile = profile
          self.pref = pref
          completion(profile, preference, nil)
        }
      }
    }
    func signIn(email: String, password: String, completion: @escaping (_ profile: UserProfile?, _ pref: preference?, _ error: Error?) -> Void) {
      Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
        if let error = error {
          print("Error signing in: \(error)")
          completion(nil, nil, error)
          return
        }

        guard let user = result?.user else { return }
        print("User \(user.uid) signed in.")

        self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
          if let error = error {
            print("Error while fetching the user profile: \(error)")
            completion(nil, nil, error)
            return
          }

//          self.profile = profile
          completion(profile, nil, nil)
        }
        self.profileRepository.fetchPref(userId: user.uid) { (pref, error) in
            if let error = error {
                print("Error while fetching user preference: \(error)")
                completion(nil, nil, error)
                return
            }
//            self.pref = pref
            completion(self.profile, pref, nil)
        }
      }
    }

    func signOut() {
      do {
        try Auth.auth().signOut()
        self.session = nil
        self.profile = nil
        self.pref = nil
        self.onGoingBets = []
        self.wonBets = []
        self.lostBets = []
      }
      catch let signOutError as NSError {
        print("Error signing out: \(signOutError)")
      }
    }
    func changePassword(email: String, currentPassword: String, newPassword: String, completion: @escaping (Error?) -> Void){
            let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
            Auth.auth().currentUser?.reauthenticate(with: credential, completion:{(result, error) in
                if let error = error {completion(error)}
                else {
                    Auth.auth().currentUser?.updatePassword(to: newPassword, completion: {(error) in completion(error)})
                }
            } )
        }
    
    func confirmUpdatedPref(NFL: Bool, MLB: Bool, NBA: Bool, NHL: Bool, NCAAF: Bool, EPL: Bool, MLS: Bool, SERIEA: Bool, LALIGA: Bool, UEFA: Bool,completion: @escaping (_ pref: preference?, _ error: Error?) -> Void) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            self.profileRepository.updatePref(userId: uid, NFL: NFL, MLB: MLB, NBA: NBA, NHL: NHL, NCAAF: NCAAF, EPL: EPL, MLS: MLS, SERIEA: UEFA, LALIGA: LALIGA, UEFA: SERIEA){ (pref, error) in
                if let error = error {
                    print("Error whil confirm updating user preference: \(error)")
                    completion(nil, nil)
                    return
                }
                self.pref = pref
            }
        }
    }
    func resetPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func submitOrder(id: String, userId: String,time: String, team_Name1: String, team_Name2: String, SelectedOdd: Double, ExpectedEarning: Double, value: String, purchase: String, homeTeam: String, gameID: String, completion: @escaping (_ order: OrderDetails?, _ error: Error?) -> Void){
        let orderDetail = OrderDetails(id: id, time: time, team_Name1: team_Name1, team_Name2: team_Name2, SelectedOdd: SelectedOdd, ExpectedEarning: ExpectedEarning, value: value, purchase: purchase, homeTeam: homeTeam, gameID: gameID)
        self.orderRespository.createOrder(userId: userId, order: orderDetail){
            (order, error) in
              if let error = error {
                print("Error while submitting betting order: \(error)")
                completion(nil, error)
                return
              }
              self.order = order
              completion(order, nil)
        }
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    deinit {
        unbind()
    }
}

struct User {
    var uid: String
    var email: String? //? = optional
    var displayName: String?
    init(uid: String, email: String?, displayName: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
//#endif
