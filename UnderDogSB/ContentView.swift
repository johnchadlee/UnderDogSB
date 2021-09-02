//
//  ContentView.swift
//  Shared
//
//  Created by John Lee on 2/27/21.
//
//import SwiftUICharts
import iLineChart
import SwiftUI
import Firebase
import UIKit
import Foundation

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    func getUser() {
        session.listen()
    }
    var body: some View {
        Group {
            if(session.session != nil){
                LoggedInView()
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}

//Emcompases all users functions
//Navigate with TabView
struct LoggedInView : View {
    @EnvironmentObject var session: SessionStore
    @State private var selection = 0
    @State var searchText = ""
    //Home Screen//
    var body: some View{
        TabView(selection: $selection) {
            HomeTabView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
                .tag(0)
            SearchEventsView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            ArchiveView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "list.bullet")
                }
                .tag(2)
            ProfileTabView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
                .tag(3)
        }
        .accentColor(.neonGreen)
    }
}

struct HomeTabView : View {

    @EnvironmentObject var session: SessionStore
    @State var showOnGoing = false
    @State var showUpComing = false
    @Environment(\.colorScheme) var colorScheme
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Match(id: "", home_team: "", away_team: "", date: "", home_odd: 0.0, away_odd: 0.0, sports_key: "")
    
    var ScoreHistory: [Double] {
        var history = [Double]()
        //Get Score array from firestore
        history = session.profile?.score ?? []
        return history
    }
    var buyingPower: Double{
        let index = (session.profile?.score.count ?? 0 ) - 1
        var bp = (session.profile?.score[index] ?? 0)
        var aggregate: Double = 0
        session.onGoingBets.forEach{
            bet in
            aggregate += Double(bet.value) ?? 0
        }
        bp = bp - aggregate
        return bp
    }
    func displayOnGoing() {
        withAnimation{
            self.showOnGoing.toggle()
        }
    }
    var body: some View {
        
        ZStack{
            List{
                VStack{
                    let currentScoreIndex = (session.profile?.score.count ?? 0 ) - 1
                    let balance = "$ \(session.profile?.score[currentScoreIndex].description ?? "?")"
                    if(colorScheme == .dark){
                        iLineChart(
                            data: ScoreHistory,
                            title: session.profile?.displayName,
                            subtitle: balance,
                            style: .dark,
                            lineGradient:  GradientColor.green,
                            titleColor: Color.neonRed,
                            curvedLines: false,
                            displayChartStats: true,
                            titleFont: .system(size: 30, weight: .bold, design: .rounded),
                            subtitleFont: .system(size: 24, weight: .bold, design: .monospaced)
                        )
                            .frame(height: 400)
                    }
                    else{
                        iLineChart(
                            data: ScoreHistory,
                            title: session.profile?.displayName,
                            subtitle: balance,
                            style: .tertiary,
                            lineGradient:  GradientColor.green,
                            curvedLines: false,
                            displayChartStats: true,
                            titleFont: .system(size: 30, weight: .bold, design: .rounded),
                            subtitleFont: .system(size: 24, weight: .bold, design: .monospaced)
                        )
                        .frame(height: 400)
                    }
                    Divider()
                    VStack{
                        HStack{
                            Text("Buying Power: ")
                                .font(.custom("NotoSans-Bold", size: 20))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .offset(x: 15.0, y: 5.0)
                            Text("$\(buyingPower,specifier:"%.2f")")
                                .bold()
                        }
                    }
                    Divider()
                    //Ongoing Bets
                    VStack{
                        Button(action: displayOnGoing, label: {
                            HStack(){
                                Text("Ongoing Bets")
                                    .font(.custom("NotoSans-Medium", size: 25))
                                if(self.showOnGoing == false){
                                Text("▼")
                                }else {
                                    Text("▲")
                                }
                            }
                            .alignmentGuide(.leading){
                                d in d[.trailing]
                            }
                            .offset(x: 74.0, y: 5.0)
                        })
                            .frame(width: .infinity, height: 50, alignment: .leading)
                        if showOnGoing == true {
                                OnGoing()
                        }
                    }
                    .padding()
                    Spacer()
                    Divider()
                    VStack{
                        //Upcoming Bets
                        Text("Upcoming Bets")
                            .frame(maxWidth: .infinity, alignment: .leading)
                                    .offset(x: -5.0, y: 5.0)
                                    .font(.custom("NotoSans-Medium", size: 25))
                            .padding()
                        UpComing(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
                        //Show all games that matches with preference
                        }
                    }
            }
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 830)  {
                        VStack {
                            let commenceTime = gamed.date
                            let id = UUID().uuidString
                            let win1 = gamed.away_odd
                            let lose1  = gamed.away_odd
                            let win2 = gamed.home_odd
                            let lose2 = gamed.home_odd
                            let OddsAmount = [win1, lose2, win2, lose1]
                            let team_Name1 = gamed.away_team
                            let team_Name2 = gamed.home_team
                            let home_team = gamed.home_team
                            let gameID = gamed.id
                            BettingView(OddsAmount: OddsAmount, team_Name1: team_Name1, team_Name2: team_Name2, bottomSheetShown: $bottomSheetShown, id: id, buyingPower:buyingPower, commenceTime: commenceTime, homeTeam: home_team, gameID: gameID)
                        }
                        .padding(geometry.safeAreaInsets)
                        .transition(.move(edge: .leading))
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}


struct ProfileTabView: View {
    @EnvironmentObject var session: SessionStore
    var body: some View{
        NavigationView{
                List{
                    NavigationLink (destination: UpdatePasswordView()){
                        Text("Update Password")
                            .font(.custom("NotoSans-Medium", size: 23))
                            .padding()
                    }
                    NavigationLink (destination: UpdatePreferenceView()){
                        Text("Update Sports Preference")
                            .font(.custom("NotoSans-Medium", size: 23))
                            .padding()
                    }
//                    NavigationLink (destination: UpdateInformationView())
//                        { Text("Update User Information").background(Color.clear)}
                    NavigationLink (destination: ContactSupportView()){
                        Text("Contact Support")
                            .font(.custom("NotoSans-Medium", size: 23))
                            .padding()
                    }
                    NavigationLink (destination: SportsBetting101View()){
                        Text("Sports Betting 101")
                            .font(.custom("NotoSans-Medium", size: 23))
                            .padding()
                    }
                    NavigationLink (destination: DarkModeView()){
                        Text("Dark Mode")
                            .font(.custom("NotoSans-Medium", size: 23))
                            .padding()
                    }
                    Button(action: session.signOut){
                        Text("Sign Out")
                            .font(.custom("NotoSans-Medium", size: 23))
                            .padding()
                    }
                }
            .navigationBarTitle("Settings")
            .font(.system(size: 30, weight: .bold, design: .rounded))
            .padding()
        }
    }
}
