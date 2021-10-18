
import Foundation
import SwiftUI

//#if (arm64)
struct UpcomingNBA: View {
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Match
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
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView{
                ForEach(games) { game in
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
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                    )
                    .padding()
                }
            }
            .onAppear{
//                session.getNBAGames();
                self.games = session.NBAGames;
            }
        }
    }
}

struct NBAView: View{
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Match(id: "", home_team: "", away_team: "", date: "", home_odd: 0.0, away_odd: 0.0, sports_key: "")
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
    var bottomSheetHeight: Int {
        if(UIScreen.main.bounds.height == 667){
            return 660;
        }
        else{
            return 780;
        }
    }
    var body: some View {
        VStack{
            UpcomingNBA(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
            
            //Show all games that matches with preference
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
                        .transition(.move(edge: .leading))
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}

struct UpcomingMLB: View {
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Match
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
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView{
                ForEach(games) { game in
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
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                    )
                    .padding()
                }
            }
        }
            .onAppear{
//                session.getMLBGames();
                self.games = session.MLBGames;
            }
    }
}

struct MLBView: View{
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Match(id: "", home_team: "", away_team: "", date: "", home_odd: 0.0, away_odd: 0.0, sports_key: "")
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
    
    var bottomSheetHeight: Int {
        if(UIScreen.main.bounds.height == 667){
            return 660;
        }
        else{
            return 780;
        }
    }
    
    var body: some View {

        VStack{
            UpcomingMLB(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
    
            //Show all games that matches with preference
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
                        .transition(.move(edge: .leading))
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}
//

//

struct UpcomingNFL: View {
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Match
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
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView{
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
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                    )
                    .padding()
                }
            }
            .onAppear{
//                session.getNFLGames();
                self.games = session.NFLGames;
            }
        }
    }
}

struct NFLView: View{
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Match(id: "", home_team: "", away_team: "", date: "", home_odd: 0.0, away_odd: 0.0, sports_key: "")
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
    
    var bottomSheetHeight: Int {
        if(UIScreen.main.bounds.height == 667){
            return 660;
        }
        else{
            return 780;
        }
    }
    
    var body: some View {
        VStack{
            UpcomingNFL(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
    
            //Show all games that matches with preference
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
                        .transition(.move(edge: .leading))
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}
//
struct UpcomingNCAAF: View {
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Match
    @Binding var bottomSheetShown : Bool
    @State var sportsTag = ["rugbyleague_nrl": "🏉",
                            "soccer_epl": "⚽",
                            "soccer_usa_mls": "⚽",
                            "basketball_euroleague": "🏀",
                            "basketball_nba": "🏀",
                            "americanfootball_nfl": "🏈",
                            "americanfootball_ncaaf": "🏈",
                            "baseball_mlb": "⚾",
                            "mma_mixed_martial_arts": "🥋",
                            "icehockey_nhl": "🏒"]
    
    var body: some View {
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
        ScrollView{
                ForEach(games) { game in
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
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                    )
                    .padding()
                }
            }
            .onAppear{
//                session.getNCAAFGames();
                self.games = session.NCAAFGames;
            }
        }
    }
}

struct NCAAFView: View{
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Match(id: "", home_team: "", away_team: "", date: "", home_odd: 0.0, away_odd: 0.0, sports_key: "")
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
    
    var bottomSheetHeight: Int {
        if(UIScreen.main.bounds.height == 667){
            return 660;
        }
        else{
            return 780;
        }
    }
    
    var body: some View {
        VStack{
            UpcomingNCAAF(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
            
            //Show all games that matches with preference
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
                        .transition(.move(edge: .leading))
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}


struct UpcomingNHL: View {
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Match
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
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView{
                ForEach(games) { game in
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
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                    )
                    .padding()
                }
            }
            .onAppear{
//                session.getNHLGames();
                self.games = session.NHLGames;
            }
        }
    }
}

struct NHLView: View{
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Match(id: "", home_team: "", away_team: "", date: "", home_odd: 0.0, away_odd: 0.0, sports_key: "")
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
    var bottomSheetHeight: Int {
        if(UIScreen.main.bounds.height == 667){
            return 660;
        }
        else{
            return 780;
        }
    }
    var body: some View {
        VStack{
            UpcomingNHL(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
        
            //Show all games that matches with preference
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
                        .transition(.move(edge: .leading))
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}
struct UpcomingEPL: View {
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Match
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
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView{
                ForEach(games) { game in
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
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                    )
                    .padding()
                }
            }
            .onAppear{
//                session.getNBAGames();
                self.games = session.EPLGames;
            }
        }
    }
}

struct EPLView: View{
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Match(id: "", home_team: "", away_team: "", date: "", home_odd: 0.0, away_odd: 0.0, sports_key: "")
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
    var bottomSheetHeight: Int {
        if(UIScreen.main.bounds.height == 667){
            return 660;
        }
        else{
            return 780;
        }
    }
    var body: some View {
        VStack{
            UpcomingEPL(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
            
            //Show all games that matches with preference
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
                        .transition(.move(edge: .leading))
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}
struct UpcomingMLS: View {
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Match
    @Binding var bottomSheetShown : Bool
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
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView{
                ForEach(games) { game in
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
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                    )
                    .padding()
                }
            }
            .onAppear{
//                session.getNBAGames();
                self.games = session.MLSGames;
            }
        }
    }
}

struct MLSView: View{
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Match(id: "", home_team: "", away_team: "", date: "", home_odd: 0.0, away_odd: 0.0, sports_key: "")
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
    var bottomSheetHeight: Int {
        if(UIScreen.main.bounds.height == 667){
            return 660;
        }
        else{
            return 780;
        }
    }
    var body: some View {
        VStack{
            UpcomingMLS(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
            
            //Show all games that matches with preference
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
                        .transition(.move(edge: .leading))
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}
struct UpcomingUEFA: View {
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Match
    @Binding var bottomSheetShown : Bool
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
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView{
                ForEach(games) { game in
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
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                    )
                    .padding()
                }
            }
            .onAppear{
//                session.getNBAGames();
                self.games = session.UEFAGames;
            }
        }
    }
}

struct UEFAView: View{
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Match(id: "", home_team: "", away_team: "", date: "", home_odd: 0.0, away_odd: 0.0, sports_key: "")
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
    var bottomSheetHeight: Int {
        if(UIScreen.main.bounds.height == 667){
            return 660;
        }
        else{
            return 780;
        }
    }
    var body: some View {
        VStack{
            UpcomingUEFA(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
            
            //Show all games that matches with preference
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
                        .transition(.move(edge: .leading))
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}
struct UpcomingSerieA: View {
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Match
    @Binding var bottomSheetShown : Bool
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
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView{
                ForEach(games) { game in
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
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                    )
                    .padding()
                }
            }
            .onAppear{
//                session.getNBAGames();
                self.games = session.SerieAGames;
            }
        }
    }
}

struct SerieAView: View{
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Match(id: "", home_team: "", away_team: "", date: "", home_odd: 0.0, away_odd: 0.0, sports_key: "")
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
    var bottomSheetHeight: Int {
        if(UIScreen.main.bounds.height == 667){
            return 660;
        }
        else{
            return 780;
        }
    }
    var body: some View {
        VStack{
            UpcomingSerieA(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
            
            //Show all games that matches with preference
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
                        .transition(.move(edge: .leading))
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}
struct UpcomingLaLiga: View {
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @Binding var gamed : Match
    @Binding var bottomSheetShown : Bool
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
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView{
                ForEach(games) { game in
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
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                    )
                    .padding()
                }
            }
            .onAppear{
//                session.getNBAGames();
                self.games = session.LaLigaGames;
            }
        }
    }
}

struct LaLigaView: View{
    @State var games: [Match] = []
    @EnvironmentObject var session: SessionStore
    @State private var bottomSheetShown = false
    @State private var Odds = 0
    @State var OddsAmount = []
    @State private var hidesheet = false
    @State var gamed = Match(id: "", home_team: "", away_team: "", date: "", home_odd: 0.0, away_odd: 0.0, sports_key: "")
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
    var bottomSheetHeight: Int {
        if(UIScreen.main.bounds.height == 667){
            return 660;
        }
        else{
            return 780;
        }
    }
    var body: some View {
        VStack{
            UpcomingLaLiga(gamed: $gamed, bottomSheetShown: $bottomSheetShown)
            
            //Show all games that matches with preference
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
                        .transition(.move(edge: .leading))
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}
//#endif
