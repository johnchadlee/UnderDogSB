//
//  SearchEventsView.swift
//  UnderDog Prototype
//
//  Created by John Lee on 5/27/21.
//
import Foundation
import SwiftUI
import UIKit

//#if (arm64)
struct SearchEventsView: View {
 //   @State var posts: [Initial.Datas] = []
    @State var text = ""
    @EnvironmentObject var session: SessionStore
    @State private var isSearching = false
    
    let SportNBA = ["NBA"]
    let SportMLS = ["MLS"]
    let SportNFL = ["NFL"]
    let SportAFL = ["AFL"]
    let SportEPL = ["EPL"]
    let SportMLB = ["MLB"]
    let SportEuro  = ["Euro League"]
    let SportNCAAF = ["NCAAF"]
    let SportNHL = ["NHL"]
    let SportMMA = ["MMA"]
    let SportNRL = ["NRL"]
    let SportSERIEA = ["SERIEA"]
    let SportUEFA = ["UEFA"]
    let SportLALIGA = ["LALIGA"]
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.Neumorphic.main.ignoresSafeArea()
            ScrollView{
                HStack{
                    HStack{
                        TextField("Search Sport...", text: $text)
                            .padding(.leading, 24)
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(6)
                    .padding(.horizontal)
                    .onTapGesture (perform: {
                        isSearching = true
                    })
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                                Spacer()
                            
                            if isSearching {
                                Button(action: { text = ""}, label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.vertical)
                                })
                        
                            }
                        }.padding(.horizontal, 32)
                        .foregroundColor(.gray)
                    ).transition(.move(edge: .trailing))
                    .animation(.spring())
                    
                    if isSearching{
                        Button(action: {
                            isSearching = false
                            text = ""
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }, label: {
                            Text("Cancel")
                            .padding(.trailing)
                            .padding(.leading, 0)
                        })
                        .transition(.move(edge: .trailing))
                        .animation(.spring())
                    }
                }
                ForEach(SportNCAAF.filter {self.text.isEmpty ? true :$0.contains(text)}, id:\.self) {String in
                    HStack{
                       NavigationLink(destination: NCAAFView()) {
                            Text("NCAAF 🏈 🇺🇸")
                            Spacer()
                       }.padding()
                       .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    }.padding()
//                    Divider()
//                        .padding(.leading)
                }
                ForEach(SportMLB.filter {self.text.isEmpty ? true :$0.contains(text)}, id:\.self) {String in
                    HStack{
                       NavigationLink(destination: MLBView()) {
                            Text("MLB ⚾ 🇺🇸")
                            Spacer()
                       }.padding()
                       .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    }.padding()
//                    Divider()
//                        .padding(.leading)
                }
                ForEach(SportNBA.filter {self.text.isEmpty ? true :$0.contains(text)}, id:\.self) {String in
                    HStack{
                        NavigationLink(destination: NBAView()) {
                            Text("NBA 🏀 🇺🇸")
                            Spacer()
                        }.padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    }.padding()
//                    Divider()
//                        .padding(.leading)
                }
                ForEach(SportNFL.filter {self.text.isEmpty ? true :$0.contains(text)}, id:\.self) {String in
                    HStack{
                       NavigationLink(destination: NFLView()) {
                            Text("NFL 🏈 🇺🇸")
                            Spacer()
                       }.padding()
                       .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    }.padding()
//                    Divider()
//                        .padding(.leading)
                }
                ForEach(SportMLS.filter {self.text.isEmpty ? true :$0.contains(text)}, id:\.self) {String in
                    HStack{
                       NavigationLink(destination: MLSView()) {
                            Text("MLS ⚽ 🇺🇸")
                            Spacer()
                       }.padding()
                       .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    }.padding()
//                    Divider()
//                        .padding(.leading)
                }
                ForEach(SportEPL.filter {self.text.isEmpty ? true :$0.contains(text)}, id:\.self) {String in
                    HStack{
                       NavigationLink(destination: EPLView()) {
                            Text("EPL ⚽ 🇬🇧")
                            Spacer()
                       }.padding()
                       .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    }.padding()
//                    Divider()
//                        .padding(.leading)
                }
                ForEach(SportUEFA.filter {self.text.isEmpty ? true :$0.contains(text)}, id:\.self) {String in
                    HStack{
                       NavigationLink(destination: UEFAView()) {
                            Text("UEFA ⚽ 🇪🇺")
                            Spacer()
                       }.padding()
                       .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    }.padding()
//                    Divider()
//                        .padding(.leading)
                }
                ForEach(SportSERIEA.filter {self.text.isEmpty ? true :$0.contains(text)}, id:\.self) {String in
                    HStack{
                       NavigationLink(destination: SerieAView()) {
                            Text("Serie A ⚽ 🇮🇹")
                            Spacer()
                       }.padding()
                       .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    }.padding()
//                    Divider()
//                        .padding(.leading)
                }
                ForEach(SportLALIGA.filter {self.text.isEmpty ? true :$0.contains(text)}, id:\.self) {String in
                    HStack{
                       NavigationLink(destination: LaLigaView()) {
                            Text("La Liga ⚽ 🇪🇸")
                            Spacer()
                       }.padding()
                       .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    }.padding()
//                    Divider()
//                        .padding(.leading)
                }



            }
            .foregroundColor(.primary)
            .navigationTitle("Events")
            }
        }.onAppear(){
            session.getNHLGames();
            session.getMLBGames();
            session.getNCAAFGames();
            session.getNFLGames();
            session.getNBAGames();
            session.getEPLGames();
            session.getMLSGames();
            session.getUEFAGames();
            session.getSerieAGames();
            session.getLaLigaGames();
        }
    }
}
//#endif
