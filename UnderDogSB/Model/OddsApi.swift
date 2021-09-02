//
//  data.swift
//  UnderDog Prototype
//
//  Created by John Lee on 3/21/21.
//
import Foundation
import SwiftUI

// As of right now, OddsApi pull data from Odds Api and only displays the sports they have

class OddsApi {
//    @State private var API_KEY = "fdddc894261e9b8b7252cef12463faec"
    
    func getPosts(completion: @escaping ([Initial.Datas]) -> () ) {
        
        let urlString = "https://api.the-odds-api.com/v3/sports/?apiKey=2070c40f8391b3c091261733bb2b4094"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (info, _, _) in
            let posts = try! JSONDecoder().decode(Initial.self, from: info!)
            
            DispatchQueue.main.async {
//                print(posts.data)
                completion(posts.data)
            }
        }
        .resume()
    }
    //Football Data
    func getUSFootballOdds(completion: @escaping ([Datum]) -> () ) {
        
        guard let url = URL(string: "https://api.the-odds-api.com/v3/odds/?apiKey=2070c40f8391b3c091261733bb2b4094&sport=americanfootball_nfl&region=us&mkt=h2h") else { return }
        URLSession.shared.dataTask(with: url) { (info, _, _) in
            let games = try! JSONDecoder().decode(Welcome.self, from: info!)
            
            DispatchQueue.main.async {
                completion(games.data)
            }
        }
        .resume()
    }
    func getAUFootballOdds(completion: @escaping ([Datum]) -> () ) {
        
        guard let url = URL(string: "https://api.the-odds-api.com/v3/odds/?apiKey=2070c40f8391b3c091261733bb2b4094&sport=aussierules_afl&region=au&mkt=h2h") else { return }
        URLSession.shared.dataTask(with: url) { (info, _, _) in
            let games = try! JSONDecoder().decode(Welcome.self, from: info!)
            
            DispatchQueue.main.async {
                completion(games.data)
            }
        }
        .resume()
    }
    //Baseball Data
    func getUSBaseballOdds(completion: @escaping ([Datum]) -> () ) {
        
        guard let url = URL(string: "https://api.the-odds-api.com/v3/odds/?apiKey=a78ad89c68dc1940aebf8f926a60bcfe&sport=baseball_mlb&region=us&mkt=h2h") else { return }
        URLSession.shared.dataTask(with: url) { (info, _, _) in
            let games = try! JSONDecoder().decode(Welcome.self, from: info!)
            
            DispatchQueue.main.async {
                completion(games.data)
            }
        }
        .resume()
    }
    //BasketBall
    func getUSBasketBallOdds(completion: @escaping ([Datum]) -> () ) {
        
        guard let url = URL(string: "https://api.the-odds-api.com/v3/odds/?apiKey=2070c40f8391b3c091261733bb2b4094&sport=basketball_nba&region=us&mkt=h2h") else { return }
        URLSession.shared.dataTask(with: url) { (info, _, _) in
            let games = try! JSONDecoder().decode(Welcome.self, from: info!)
            
            DispatchQueue.main.async {
                completion(games.data)
            }
        }
        .resume()
    }
    func getEUBasketBallOdds(completion: @escaping ([Datum]) -> () ) {
        
        guard let url = URL(string: "https://api.the-odds-api.com/v3/odds/?apiKey=2070c40f8391b3c091261733bb2b4094&sport=basketball_euroleague&region=eu&mkt=h2h") else { return }
        URLSession.shared.dataTask(with: url) { (info, _, _) in
            let games = try! JSONDecoder().decode(Welcome.self, from: info!)
            
            DispatchQueue.main.async {
                completion(games.data)
            }
        }
        .resume()
    }
    //Ice Hockey
    func getIceHockeyOdds(completion: @escaping ([Datum]) -> () ) {
        
        guard let url = URL(string: "https://api.the-odds-api.com/v3/odds/?apiKey=2070c40f8391b3c091261733bb2b4094&sport=icehockey_nhl&region=us&mkt=h2h") else { return }

        URLSession.shared.dataTask(with: url) { (info, _, _) in
            let games = try! JSONDecoder().decode(Welcome.self, from: info!)
            
            DispatchQueue.main.async {
                completion(games.data)
            }
        }
        .resume()
    }
    //MMA
    func getMMAOdds(completion: @escaping ([Datum]) -> () ) {
        
        guard let url = URL(string: "https://api.the-odds-api.com/v3/odds/?apiKey=2070c40f8391b3c091261733bb2b4094&sport=mma_mixed_martial_arts&region=us&mkt=h2h") else { return }

        URLSession.shared.dataTask(with: url) { (info, _, _) in
            let games = try! JSONDecoder().decode(Welcome.self, from: info!)
            
            DispatchQueue.main.async {
                completion(games.data)
            }
        }
        .resume()
    }
    //Rugby
    func getAURugbyOdds(completion: @escaping ([Datum]) -> () ) {
        
        guard let url = URL(string: "https://api.the-odds-api.com/v3/odds/?apiKey=2070c40f8391b3c091261733bb2b4094&sport=rugbyleague_nrl&region=au&mkt=h2h") else { return }
        URLSession.shared.dataTask(with: url) { (info, _, _) in
            let games = try! JSONDecoder().decode(Welcome.self, from: info!)
            
            DispatchQueue.main.async {
                completion(games.data)
            }
        }
        .resume()
    }
    //Soccer Data
    func getUKSoccerOdds(completion: @escaping ([Datum]) -> () ) {
        
        guard let url = URL(string: "https://api.the-odds-api.com/v3/odds/?apiKey=2070c40f8391b3c091261733bb2b4094&sport=soccer_epl&region=uk&mkt=h2h") else { return }
        URLSession.shared.dataTask(with: url) { (info, _, _) in
            let games = try! JSONDecoder().decode(Welcome.self, from: info!)
            
            DispatchQueue.main.async {
//                print(games.data)
                completion(games.data)
            }
        }
        .resume()
    }
    func getUSSoccerOdds(completion: @escaping ([Datum]) -> () ) {
        
        guard let url = URL(string: "https://api.the-odds-api.com/v3/odds/?apiKey=2070c40f8391b3c091261733bb2b4094&sport=soccer_usa_mls&region=us&mkt=h2h") else { return }

        URLSession.shared.dataTask(with: url) { (info, _, _) in
            let games = try! JSONDecoder().decode(Welcome.self, from: info!)
            
            DispatchQueue.main.async {
                completion(games.data)
            }
        }
        .resume()
    }
}
