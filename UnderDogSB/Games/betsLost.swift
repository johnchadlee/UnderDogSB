//
//  betsLost.swift
//  UnderDog Prototype
//
//  Created by John Lee on 7/20/21.
//

import SwiftUI

//#if (arm64)
struct betsLost: View {
    @State var team_Name1 : String  = ""
    @State var team_Name2 : String = ""
    @State var SelectedOdd: Double = 0
    @State var ExpectedEarning : Double = 0
    @State var value : String = ""
    @EnvironmentObject var session: SessionStore
    @State var betsLost: [OrderDetails] = []
    // create order array
    var body: some View {
        VStack(spacing: 15){
            ForEach(betsLost) { ongoing in
                VStack(alignment: .leading){
                Text("\(ongoing.team_Name1)  vs  \(ongoing.team_Name2)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 12))
                    .foregroundColor(.orange)
                Text("\(ongoing.purchase)")
                    .fontWeight(.bold)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                Text("Wager: $\(Double(ongoing.value) ?? 0,specifier:"%.2f")")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                Text("Potential Winnings: $\(ongoing.ExpectedEarning,specifier:"%.2f")")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
//                Divider()
                }.padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
//                .padding()
            }
        }
        .onAppear(){
            betsLost = session.lostBets
        }
    }
}
//#endif
