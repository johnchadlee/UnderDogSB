//
//  bettingHistory.swift
//  UnderDog Prototype
//
//  Created by John Lee on 5/17/21.
//
import Foundation
import UIKit
import SwiftUI

//#if (arm64)
struct ArchiveView : View {
@EnvironmentObject var session: SessionStore
@State var posts: [Initial.Datas] = []
    func dummy(){}
    var body: some View {
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
        VStack{
            Text("Betting History")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
//            Spacer()
            HStack (alignment: .top, spacing: 10) {
                ScrollView{
                    VStack{
                        Text("Won")
                            .foregroundColor(.green)
                            .padding()
                        betsWon()
                    }
                }.padding(.top)
                Divider()
                ScrollView{
                    VStack{
                        Text("Lost")
                            .foregroundColor(.red)
                            .padding()
                        betsLost()
                    }
                }.padding(.top)
            }
        }
        .font(.custom("NotoSans-Medium", size: 25))
        }
    }
}
//#endif
//struct ArchiveView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchiveView()
//    }
//}
