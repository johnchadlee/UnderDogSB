//
//  OnGoing.swift
//  UnderDog Prototype
//
//  Created by John Lee on 5/13/21.
//

import SwiftUI

struct OnGoing: View {
    @State var team_Name1 : String  = ""
    @State var team_Name2 : String = ""
    @State var SelectedOdd: Double = 0
    @State var ExpectedEarning : Double = 0
    @State var value : String = ""
    @EnvironmentObject var session: SessionStore
    @State var OnGoingBets: [OrderDetails] = []
    // create order array
    var body: some View {
        VStack(alignment: .leading){
            ForEach(OnGoingBets) { ongoing in
                
                Text("\(ongoing.team_Name1)  vs  \(ongoing.team_Name2)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 12))
                    .foregroundColor(.orange)
                Text("\(ongoing.purchase)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text("Wager: $\(Double(ongoing.value) ?? 0,specifier:"%.2f")")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text("Potential Winnings: $\(ongoing.ExpectedEarning,specifier:"%.2f")")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 12))
                    .foregroundColor(.green)
                Divider()
            }
        }
        .onAppear(){
            OnGoingBets = session.onGoingBets
        }
    }
}
