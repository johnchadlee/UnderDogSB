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

//#if (arm64)
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
                    .transition(.move(edge: .trailing))
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
        .accentColor(.neonOceanBlue)
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
    var spacing: Float {
        if(UIScreen.main.bounds.height == 667){
            return 100.0;
        }
        else if(UIScreen.main.bounds.height == 896){
            return 85.0;
        }
        else{
            return 100.0;
        }
    }
    
    var bottomSheetHeight: Int {
        if(UIScreen.main.bounds.height == 667){
            return 660;
        }
        else{
            return 830;
        }
    }
    
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
    func displayUpComing() {
        withAnimation{
            self.showUpComing.toggle()
        }
    }
    var body: some View {
        
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView{
                Spacer()
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
                            .background(
                                RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                            )
                            .padding()
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
                        .background(
                            RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                        )
                        .padding()
                    }
//                    Divider()
                    VStack{
                        HStack{
                            Text("Buying Power: ")
                                .font(.system(size: 20, weight: .regular, design: .rounded)).bold()
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .offset(x: 15.0, y: 5.0)
                            Spacer()
                            Text("$\(buyingPower,specifier:"%.2f")")
                                .bold()
                        }.padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20))
                        )
                    }.padding()
//                    Divider()
                    //Ongoing Bets
                    VStack{
                        Button(action: displayOnGoing, label: {
                            HStack(){
                                Text("Ongoing Bets")
                                    .font(.system(size: 25, weight: .regular, design: .rounded))
                                if(self.showOnGoing == false){
                                Text("▼")
                                }else {
                                    Text("▲")
                                }
                                Spacer()
                            }
                            .alignmentGuide(.leading){
                                d in d[.trailing]
                            }
                        }).softButtonStyle(RoundedRectangle(cornerRadius: 20))
                        if showOnGoing == true {
                                OnGoing()
                        }
                    }.buttonStyle(PlainButtonStyle())
                    .padding()
//                    Spacer()
//                    Divider()
                    VStack{
                        Button(action: displayUpComing, label: {
                            HStack(){
                                Text("Upcoming Bets")
                                    .font(.system(size: 25, weight: .regular, design: .rounded))
                                if(self.showUpComing == false){
                                Text("▼")
                                }else {
                                    Text("▲")
                                }
                                Spacer()
                            }
                            .alignmentGuide(.leading){
                                d in d[.trailing]
                            }
                        }).softButtonStyle(RoundedRectangle(cornerRadius: 20))
                        if showUpComing == true{
                            UpComing(gamed: $gamed ,bottomSheetShown: $bottomSheetShown)
                            //Show all games that matches with preference
                        }
                    }.buttonStyle(PlainButtonStyle())
                    .padding()
                }
                Spacer()
            }
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: CGFloat(bottomSheetHeight))  {
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
//                        .transition(.move(edge: .leading))
                    }
                    .transition(.scale(scale: 0.5, anchor: .bottom))
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
            ZStack{
                Color.Neumorphic.main.ignoresSafeArea();
                ScrollView{
                    VStack(spacing: 1){
                    HStack{
                    NavigationLink (destination: UpdatePasswordView()){
                        Text("Update Password")
                            .font(.system(size: 20))
                            .padding()
                    }.buttonStyle(PlainButtonStyle())
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    Spacer()
                    }.padding()
                    HStack{
                    NavigationLink (destination: UpdatePreferenceView()){
                        Text("Update Sports Preference")
                            .font(.system(size: 20))
                            .padding()
                    }.buttonStyle(PlainButtonStyle())
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
//                    NavigationLink (destination: UpdateInformationView())
//                        { Text("Update User Information").background(Color.clear)}
                    Spacer()
                    }.padding()
                    HStack{
                    NavigationLink (destination: ContactSupportView()){
                        Text("Contact Support")
                            .font(.system(size: 20))
                            .padding()
                    }.buttonStyle(PlainButtonStyle())
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    Spacer()
                    }.padding()
                    HStack{
                    NavigationLink (destination: SportsBetting101View()){
                        Text("Sports Betting 101")
                            .font(.system(size: 20))
                            .padding()
                    }.buttonStyle(PlainButtonStyle())
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    Spacer()
                    }.padding()
                    HStack{
                    NavigationLink (destination: DarkModeView()){
                        Text("Dark Mode")
                            .font(.system(size: 20))
                            .padding()
                    }.buttonStyle(PlainButtonStyle())
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    Spacer()
                    }.padding()
                    HStack{
                    Button(action: session.signOut){
                        Text("Sign Out")
                            .font(.system(size: 20))
//                            .padding()
                    }.softButtonStyle(Capsule(), pressedEffect: .hard)
                    Spacer()
                    }.padding()
                    }
                }
            .navigationBarTitle("Settings")
//            .font(.system(size: 30, weight: .bold, design: .rounded))
            .padding()
            }
        }
    }
}
//#endif
