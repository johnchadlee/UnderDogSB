
import Foundation
import SwiftUI

struct UpcomingNBA: View {
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Datum
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
            List{
                ForEach(games) { game in
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Text("Teams \(sportsTag[game.sportKey]!)")
                                Divider()
                                Text(game.teams[0])
                                    .font(.system(size: 15))
                                Divider()
                                Text(game.teams[1])
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
                                Text("\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Divider()
                                Text("-\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                Text("-\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
                                Divider()
                                Text("\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
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
                    OddsApi().getUSBasketBallOdds{
                        (games) in
                        if self.games.isEmpty {
                            self.games = games
                        }
                        else {
                            self.games += games
                        }

                    }
            }
    }
}

struct NBAView: View{
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Datum(id: "", sportKey: "", sportNice: "", teams: [], commenceTime: 0, homeTeam: "", sites: [], sitesCount: 0)
    
    var body: some View {
        VStack{
//            Text("NBA Bets")
//            .frame(maxWidth: .infinity, alignment: .leading)
//                    .offset(x: 30.0, y: 5.0)
//                    .font(.custom("NotoSans-Medium", size: 25))
//            .padding()
            UpcomingNBA(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
            
            //Show all games that matches with preference
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 830)  {
                        VStack {
                            let win1 = gamed.sites[0].odds.h2H[0]
                            let lose1  = -gamed.sites[0].odds.h2H[0]
                            let win2 = gamed.sites[0].odds.h2H[1]
                            let lose2 = -gamed.sites[0].odds.h2H[1]
                            let OddsAmount = [win1, lose2, win2, lose1]
                            let team_Name1 = gamed.teams[0]
                            let team_Name2 = gamed.teams[1]
                            BettingView(OddsAmount: OddsAmount, team_Name1: team_Name1, team_Name2: team_Name2, bottomSheetShown: $bottomSheetShown)
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

struct UpcomingSoccerEPL: View {
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Datum
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
            List{
                ForEach(games) { game in
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Text("Teams \(sportsTag[game.sportKey]!)")
                                Divider()
                                Text(game.teams[0])
                                    .font(.system(size: 15))
                                Divider()
                                Text(game.teams[1])
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
                                Text("\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Divider()
                                Text("-\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                Text("-\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
                                Divider()
                                Text("\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
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
                    OddsApi().getUKSoccerOdds{
                        (games) in
                        if self.games.isEmpty {
                            self.games = games
                        }
                        else {
                            self.games += games
                        }

                    }
            }
    }
}

struct SoccerEPLView: View{
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Datum(id: "", sportKey: "", sportNice: "", teams: [], commenceTime: 0, homeTeam: "", sites: [], sitesCount: 0)
    
    var body: some View {
        VStack{
//    Text("EPL Bets")
//        .frame(maxWidth: .infinity, alignment: .leading)
//                .offset(x: -5.0, y: 5.0)
//                .font(.custom("NotoSans-Medium", size: 25))
//        .padding()
            UpcomingSoccerEPL(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
            //Show all games that matches with preference
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 1000)  {
                        VStack {
                            let win1 = gamed.sites[0].odds.h2H[0]
                            let lose1  = -gamed.sites[0].odds.h2H[0]
                            let win2 = gamed.sites[0].odds.h2H[1]
                            let lose2 = -gamed.sites[0].odds.h2H[1]
                            let OddsAmount = [win1, lose2, win2, lose1]
                            let team_Name1 = gamed.teams[0]
                            let team_Name2 = gamed.teams[1]
                            BettingView(OddsAmount: OddsAmount, team_Name1: team_Name1, team_Name2: team_Name2, bottomSheetShown: $bottomSheetShown)
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

struct UpcomingRugby: View {
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Datum
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
            List{
                ForEach(games) { game in
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Text("Teams \(sportsTag[game.sportKey]!)")
                                Divider()
                                Text(game.teams[0])
                                    .font(.system(size: 15))
                                Divider()
                                Text(game.teams[1])
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
                                Text("\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Divider()
                                Text("-\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                Text("-\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
                                Divider()
                                Text("\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
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
                    OddsApi().getAURugbyOdds{
                        (games) in
                        if self.games.isEmpty {
                            self.games = games
                        }
                        else {
                            self.games += games
                        }

                    }
            }
    }
}

struct RugbyView: View{
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Datum(id: "", sportKey: "", sportNice: "", teams: [], commenceTime: 0, homeTeam: "", sites: [], sitesCount: 0)
    
    var body: some View {
        VStack{
//        Text("AU Rugby Bets")
//        .frame(maxWidth: .infinity, alignment: .leading)
//                .offset(x: -5.0, y: 5.0)
//                .font(.custom("NotoSans-Medium", size: 25))
//        .padding()
            UpcomingRugby(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
        
            //Show all games that matches with preference
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 830)  {
                        VStack {
                            let win1 = gamed.sites[0].odds.h2H[0]
                            let lose1  = -gamed.sites[0].odds.h2H[0]
                            let win2 = gamed.sites[0].odds.h2H[1]
                            let lose2 = -gamed.sites[0].odds.h2H[1]
                            let OddsAmount = [win1, lose2, win2, lose1]
                            let team_Name1 = gamed.teams[0]
                            let team_Name2 = gamed.teams[1]
                            BettingView(OddsAmount: OddsAmount, team_Name1: team_Name1, team_Name2: team_Name2, bottomSheetShown: $bottomSheetShown)
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

struct UpcomingEuroLeague: View {
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Datum
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
            List{
                ForEach(games) { game in
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Text("Teams \(sportsTag[game.sportKey]!)")
                                Divider()
                                Text(game.teams[0])
                                    .font(.system(size: 15))
                                Divider()
                                Text(game.teams[1])
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
                                Text("\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Divider()
                                Text("-\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                Text("-\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
                                Divider()
                                Text("\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
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
                    OddsApi().getEUBasketBallOdds{
                        (games) in
                        if self.games.isEmpty {
                            self.games = games
                        }
                        else {
                            self.games += games
                        }

                    }
            }
    }
}

struct EuroLeagueBBView: View{
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Datum(id: "", sportKey: "", sportNice: "", teams: [], commenceTime: 0, homeTeam: "", sites: [], sitesCount: 0)
    
    var body: some View {
        VStack{
//    Text("Euro League Basketball Bets")
//        .frame(maxWidth: .infinity, alignment: .leading)
//                .offset(x: -5.0, y: 5.0)
//                .font(.custom("NotoSans-Medium", size: 25))
//        .padding()
            UpcomingEuroLeague(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
    
            //Show all games that matches with preference
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 830)  {
                        VStack {
                            let win1 = gamed.sites[0].odds.h2H[0]
                            let lose1  = -gamed.sites[0].odds.h2H[0]
                            let win2 = gamed.sites[0].odds.h2H[1]
                            let lose2 = -gamed.sites[0].odds.h2H[1]
                            let OddsAmount = [win1, lose2, win2, lose1]
                            let team_Name1 = gamed.teams[0]
                            let team_Name2 = gamed.teams[1]
                            BettingView(OddsAmount: OddsAmount, team_Name1: team_Name1, team_Name2: team_Name2, bottomSheetShown: $bottomSheetShown)
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

struct UpcomingMLB: View {
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Datum
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
            List{
                ForEach(games) { game in
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Text("Teams \(sportsTag[game.sportKey]!)")
                                Divider()
                                Text(game.teams[0])
                                    .font(.system(size: 15))
                                Divider()
                                Text(game.teams[1])
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
                                Text("\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Divider()
                                Text("-\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                Text("-\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
                                Divider()
                                Text("\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
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
                    OddsApi().getUSBaseballOdds{
                        (games) in
                        if self.games.isEmpty {
                            self.games = games
                        }
                        else {
                            self.games += games
                        }

                    }
            }
    }
}

struct MLBView: View{
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Datum(id: "", sportKey: "", sportNice: "", teams: [], commenceTime: 0, homeTeam: "", sites: [], sitesCount: 0)
    
    var body: some View {
        VStack{
//    Text("NBA Bets")
//        .frame(maxWidth: .infinity, alignment: .leading)
//                .offset(x: -5.0, y: 5.0)
//                .font(.custom("NotoSans-Medium", size: 25))
//        .padding()
            
            
            UpcomingMLB(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
    
            //Show all games that matches with preference
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 830)  {
                        VStack {
                            let win1 = gamed.sites[0].odds.h2H[0]
                            let lose1  = -gamed.sites[0].odds.h2H[0]
                            let win2 = gamed.sites[0].odds.h2H[1]
                            let lose2 = -gamed.sites[0].odds.h2H[1]
                            let OddsAmount = [win1, lose2, win2, lose1]
                            let team_Name1 = gamed.teams[0]
                            let team_Name2 = gamed.teams[1]
                            BettingView(OddsAmount: OddsAmount, team_Name1: team_Name1, team_Name2: team_Name2, bottomSheetShown: $bottomSheetShown)
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

struct UpcomingMLS: View {
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Datum
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
            List{
                ForEach(games) { game in
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Text("Teams \(sportsTag[game.sportKey]!)")
                                Divider()
                                Text(game.teams[0])
                                    .font(.system(size: 15))
                                Divider()
                                Text(game.teams[1])
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
                                Text("\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Divider()
                                Text("-\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                Text("-\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
                                Divider()
                                Text("\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
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
                    OddsApi().getUSSoccerOdds{
                        (games) in
                        if self.games.isEmpty {
                            self.games = games
                        }
                        else {
                            self.games += games
                        }

                    }
            }
    }
}

struct MLSView: View{
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Datum(id: "", sportKey: "", sportNice: "", teams: [], commenceTime: 0, homeTeam: "", sites: [], sitesCount: 0)
    
    var body: some View {
        VStack{
//        Text("NBA Bets")
//            .frame(maxWidth: .infinity, alignment: .leading)
//                    .offset(x: -5.0, y: 5.0)
//                    .font(.custom("NotoSans-Medium", size: 25))
//            .padding()
            UpcomingMLS(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
    
            //Show all games that matches with preference
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 830)  {
                        VStack {
                            let win1 = gamed.sites[0].odds.h2H[0]
                            let lose1  = -gamed.sites[0].odds.h2H[0]
                            let win2 = gamed.sites[0].odds.h2H[1]
                            let lose2 = -gamed.sites[0].odds.h2H[1]
                            let OddsAmount = [win1, lose2, win2, lose1]
                            let team_Name1 = gamed.teams[0]
                            let team_Name2 = gamed.teams[1]
                            BettingView(OddsAmount: OddsAmount, team_Name1: team_Name1, team_Name2: team_Name2, bottomSheetShown: $bottomSheetShown)
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

struct UpcomingMMA: View {
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Datum
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
            List{
                ForEach(games) { game in
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Text("Teams \(sportsTag[game.sportKey]!)")
                                Divider()
                                Text(game.teams[0])
                                    .font(.system(size: 15))
                                Divider()
                                Text(game.teams[1])
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
                                Text("\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Divider()
                                Text("-\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                Text("-\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
                                Divider()
                                Text("\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
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
                    OddsApi().getMMAOdds{
                        (games) in
                        if self.games.isEmpty {
                            self.games = games
                        }
                        else {
                            self.games += games
                        }

                    }
            }
    }
}

struct MMAView: View{
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Datum(id: "", sportKey: "", sportNice: "", teams: [], commenceTime: 0, homeTeam: "", sites: [], sitesCount: 0)
    
    var body: some View {
        VStack{
//    Text("MMA Bets")
//        .frame(maxWidth: .infinity, alignment: .leading)
//                .offset(x: -5.0, y: 5.0)
//                .font(.custom("NotoSans-Medium", size: 25))
//        .padding()
            UpcomingMMA(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
        
        //Show all games that matches with preference
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 830)  {
                        VStack {
                            let win1 = gamed.sites[0].odds.h2H[0]
                            let lose1  = -gamed.sites[0].odds.h2H[0]
                            let win2 = gamed.sites[0].odds.h2H[1]
                            let lose2 = -gamed.sites[0].odds.h2H[1]
                            let OddsAmount = [win1, lose2, win2, lose1]
                            let team_Name1 = gamed.teams[0]
                            let team_Name2 = gamed.teams[1]
                            BettingView(OddsAmount: OddsAmount, team_Name1: team_Name1, team_Name2: team_Name2, bottomSheetShown: $bottomSheetShown)
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

struct UpcomingNFL: View {
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Datum
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
            List{
                ForEach(games) { game in
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Text("Teams \(sportsTag[game.sportKey]!)")
                                Divider()
                                Text(game.teams[0])
                                    .font(.system(size: 15))
                                Divider()
                                Text(game.teams[1])
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
                                Text("\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Divider()
                                Text("-\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                Text("-\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
                                Divider()
                                Text("\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
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
                    OddsApi().getUSFootballOdds{
                        (games) in
                        if self.games.isEmpty {
                            self.games = games
                        }
                        else {
                            self.games += games
                        }

                    }
            }
    }
}

struct NFLView: View{
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Datum(id: "", sportKey: "", sportNice: "", teams: [], commenceTime: 0, homeTeam: "", sites: [], sitesCount: 0)
    
    var body: some View {
        VStack{
//            Text("NBA Bets")
//                .frame(maxWidth: .infinity, alignment: .leading)
//                        .offset(x: -5.0, y: 5.0)
//                        .font(.custom("NotoSans-Medium", size: 25))
//                .padding()
            UpcomingNFL(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
    
            //Show all games that matches with preference
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 830)  {
                        VStack {
                            let win1 = gamed.sites[0].odds.h2H[0]
                            let lose1  = -gamed.sites[0].odds.h2H[0]
                            let win2 = gamed.sites[0].odds.h2H[1]
                            let lose2 = -gamed.sites[0].odds.h2H[1]
                            let OddsAmount = [win1, lose2, win2, lose1]
                            let team_Name1 = gamed.teams[0]
                            let team_Name2 = gamed.teams[1]
                            BettingView(OddsAmount: OddsAmount, team_Name1: team_Name1, team_Name2: team_Name2, bottomSheetShown: $bottomSheetShown)
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

struct UpcomingAFL: View {
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Datum
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
            List{
                ForEach(games) { game in
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Text("Teams \(sportsTag[game.sportKey]!)")
                                Divider()
                                Text(game.teams[0])
                                    .font(.system(size: 15))
                                Divider()
                                Text(game.teams[1])
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
                                Text("\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Divider()
                                Text("-\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                Text("-\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
                                Divider()
                                Text("\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
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
                    OddsApi().getAUFootballOdds{
                        (games) in
                        if self.games.isEmpty {
                            self.games = games
                        }
                        else {
                            self.games += games
                        }

                    }
            }
    }
}

struct AUFootballView: View{
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Datum(id: "", sportKey: "", sportNice: "", teams: [], commenceTime: 0, homeTeam: "", sites: [], sitesCount: 0)
    
    var body: some View {
        VStack{
//            Text("Australian Football Bets")
//                .frame(maxWidth: .infinity, alignment: .leading)
//                        .offset(x: -5.0, y: 5.0)
//                        .font(.custom("NotoSans-Medium", size: 25))
//                .padding()
            UpcomingAFL(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
            
            //Show all games that matches with preference
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 830)  {
                        VStack {
                            let win1 = gamed.sites[0].odds.h2H[0]
                            let lose1  = -gamed.sites[0].odds.h2H[0]
                            let win2 = gamed.sites[0].odds.h2H[1]
                            let lose2 = -gamed.sites[0].odds.h2H[1]
                            let OddsAmount = [win1, lose2, win2, lose1]
                            let team_Name1 = gamed.teams[0]
                            let team_Name2 = gamed.teams[1]
                            BettingView(OddsAmount: OddsAmount, team_Name1: team_Name1, team_Name2: team_Name2, bottomSheetShown: $bottomSheetShown)
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

struct UpcomingNHL: View {
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Datum
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
            List{
                ForEach(games) { game in
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Text("Teams \(sportsTag[game.sportKey]!)")
                                Divider()
                                Text(game.teams[0])
                                    .font(.system(size: 15))
                                Divider()
                                Text(game.teams[1])
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
                                Text("\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Divider()
                                Text("-\(game.sites[0].odds.h2H[0], specifier: "%.2f")")
                                Spacer()
                            }
                            VStack{
                                Spacer()
                                Text("-\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
                                Divider()
                                Text("\(game.sites[0].odds.h2H[1], specifier: "%.2f")")
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
                    OddsApi().getIceHockeyOdds{
                        (games) in
                        if self.games.isEmpty {
                            self.games = games
                        }
                        else {
                            self.games += games
                        }

                    }
            }
    }
}

struct NHLView: View{
    @State var games: [Datum] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Datum(id: "", sportKey: "", sportNice: "", teams: [], commenceTime: 0, homeTeam: "", sites: [], sitesCount: 0)
    
    var body: some View {
        VStack{
//        Text("NHL Bets")
//            .frame(maxWidth: .infinity, alignment: .leading)
//                    .offset(x: -5.0, y: 5.0)
//                    .font(.custom("NotoSans-Medium", size: 25))
//            .padding()
            UpcomingNHL(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
        
            //Show all games that matches with preference
            if (bottomSheetShown != false) {
                GeometryReader{ geometry in
                    BottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 830)  {
                        VStack {
                            let win1 = gamed.sites[0].odds.h2H[0]
                            let lose1  = -gamed.sites[0].odds.h2H[0]
                            let win2 = gamed.sites[0].odds.h2H[1]
                            let lose2 = -gamed.sites[0].odds.h2H[1]
                            let OddsAmount = [win1, lose2, win2, lose1]
                            let team_Name1 = gamed.teams[0]
                            let team_Name2 = gamed.teams[1]
                            BettingView(OddsAmount: OddsAmount, team_Name1: team_Name1, team_Name2: team_Name2, bottomSheetShown: $bottomSheetShown)
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

