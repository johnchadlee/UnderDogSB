//
//  PostList.swift
//  UnderDog Prototype
//
//  Created by John Lee on 3/21/21.
//
import Foundation
import SwiftUI

struct UpComing: View {
    @State var games: [Match] = []
    @Binding var gamed : Match
    @EnvironmentObject var session: SessionStore
    @Binding var bottomSheetShown : Bool
    @State var sportsTag = ["rugbyleague_nrl": "🏉",
                            "soccer_epl": "⚽",
                            "soccer_usa_mls": "⚽",
                            "basketball_euroleague": "🏀",
                            "basketball_nba": "🏀",
                            "americanfootball_nfl": "🏈",
                            "aussierules_afl": "🏈",
                            "baseball_mlb": "⚾",
                            "mma_mixed_martial_arts": "🥋",
                            "icehockey_nhl": "🏒"]
    
    
    
    var body: some View {
            VStack{
                ForEach(games) { game in
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            
                            VStack{
                                Text("Teams \(sportsTag[game.sports_key]!)")
                                Divider()
                                Text(game.away_team)
                                    .font(.system(size: 15))
                                Divider()
                                Text(game.home_team)
                                    .font(.system(size: 15))
                                    Spacer()
                            }
                            Spacer()
                            VStack(spacing: 0){
                            HStack(alignment: .center, spacing: 20){
                                Text("Win")
                                Text("Lose")
                            }
                            HStack{
                                Spacer()
                            VStack{
                               Spacer()
                                //Away
                                Text("\(game.away_odd, specifier: "%.2f")")
                                Divider()
                                Text("\(game.home_odd, specifier: "%.2f")")
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                //Home
                                Text("\(game.home_odd, specifier: "%.2f")")
                                Divider()
                                Text("\(game.away_odd, specifier: "%.2f")")
                                Spacer()
                            }
                                Spacer()
                            }
                            .background(Rectangle().fill(Color.green))
                            .cornerRadius(5)
                            .padding()
                            Spacer()
                            }
                            Spacer()
                        }
                        //End of HStack
                        .onTapGesture{
                            self.bottomSheetShown.toggle()
                            gamed = game
                        }
                        Spacer()
                    }       //End of VStack
                    .padding()
                }
            }
            .onAppear{
                games = session.GameMatch
//                print(games)
            }
    }
}
