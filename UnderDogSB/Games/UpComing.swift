//
//  PostList.swift
//  UnderDog Prototype
//
//  Created by John Lee on 3/21/21.
//
import Foundation
import SwiftUI
import Neumorphic

//#if (arm64)
struct UpComing: View {
    @State var games: [Match] = []
    @Binding var gamed : Match
    @EnvironmentObject var session: SessionStore
    @Binding var bottomSheetShown : Bool
    @State var tag: String = ""
    @State var sportsTag = ["rugbyleague_nrl": "🏉",
                            "soccer_epl": "⚽",
                            "soccer_usa_mls": "⚽",
                            "basketball_euroleague": "🏀",
                            "basketball_nba": "🏀",
                            "americanfootball_nfl": "🏈",
                            "aussierules_afl": "🏈",
                            "americanfootball_ncaaf": "🏈",
                            "baseball_mlb": "⚾",
                            "mma_mixed_martial_arts": "🥋",
                            "icehockey_nhl": "🏒",
                            "soccer_uefa_champs_league": "⚽",
                            "soccer_italy_serie_a": "⚽",
                            "soccer_spain_la_liga": "⚽"]
    
    
    
    var body: some View {
            VStack{
                VStack{
                    HStack{
                        Spacer()
                        Text(tag)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                        Spacer()
                    }
                }.padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
                .padding()
                ForEach(games) { game in
                    Button(action:{
                        self.bottomSheetShown.toggle()
                        gamed = game
                    }){
                    VStack{
//                        Spacer()
                        HStack{
                            Spacer()
                            Text(game.date)
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                                .underline()
                            Spacer()
                        }.padding()
                        HStack{
                            Spacer()
                            
                            VStack{
                                Text("Teams \(sportsTag[game.sports_key]!)")
                                    .foregroundColor(.primary)
                                Divider()
                                Text(game.away_team)
                                    .font(.system(size: 15))
                                    .foregroundColor(.primary)
                                Divider()
                                Text(game.home_team)
                                    .font(.system(size: 15))
                                    .foregroundColor(.primary)
                                    Spacer()
                            }
                            Spacer()
                            VStack(spacing: 0){
                            HStack(alignment: .center, spacing: 20){
                                Text("Win")
                                Text("Lose")
                            }.foregroundColor(.primary)
                            HStack{
                                Spacer()
                            VStack{
                               Spacer()
                                //Away
                                Text("\(game.away_odd, specifier: "%.2f")")
                                    .foregroundColor(.primary)
                                Divider()
                                Text("\(game.home_odd, specifier: "%.2f")")
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                //Home
                                Text("\(game.home_odd, specifier: "%.2f")")
                                    .foregroundColor(.primary)
                                Divider()
                                Text("\(game.away_odd, specifier: "%.2f")")
                                    .foregroundColor(.primary)
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
                    }//End of VStack
                    }
                    .softButtonStyle(RoundedRectangle(cornerRadius: 20), pressedEffect: .flat)
                    .padding()
                }
//                Button(action:{
//                    
//                }){
//                 Text("Load More")
//                }.softButtonStyle(RoundedRectangle(cornerRadius: 20), pressedEffect:.flat)
            }
            .onAppear{
                games = session.GameMatch
                if(games[0].sports_key == "americanfootball_ncaaf"){
                    tag = "NCAAF"
                }
                if(games[0].sports_key == "americanfootball_nfl"){
                    tag = "NFL"
                }
                if(games[0].sports_key == "basketball_nba"){
                    tag = "NBA"
                }
                if(games[0].sports_key == "baseball_mlb"){
                    tag = "MLB"
                }
                //
                if(games[0].sports_key == "soccer_spain_la_liga"){
                    tag = "LA LIGA"
                }
                if(games[0].sports_key == "soccer_italy_serie_a"){
                    tag = "SERIE A"
                }
                if(games[0].sports_key == "soccer_uefa_champs_league"){
                    tag = "UEFA"
                }
                if(games[0].sports_key == "soccer_usa_mls"){
                    tag = "MLS"
                }
                if(games[0].sports_key == "soccer_epl"){
                    tag = "EPL"
                }
//                print(games)
            }
    }
}
//#endif
