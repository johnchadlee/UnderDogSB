//
//  bettingHistory.swift
//  UnderDog Prototype
//
//  Created by John Lee on 5/17/21.
//
import Foundation
import UIKit
import SwiftUI

struct ArchiveView : View {
@EnvironmentObject var session: SessionStore
@State var posts: [Initial.Datas] = []
    func dummy(){}
    var body: some View {
        VStack{
            Text("Betting History")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
//            Spacer()
            
            HStack (alignment: .top, spacing: 10) {
                List{
                    VStack{
                        Text("Won")
                            .foregroundColor(.green)
                            .padding()
//                        OnGoing()
                        betsWon()
                    }
                }
                Divider()
                List{
                    VStack{
                        Text("Lost")
                            .foregroundColor(.red)
                            .padding()
//                        OnGoing()
                        betsLost()
                    }
                }
            }
        }
        .font(.custom("NotoSans-Medium", size: 25))
    }
}
//struct ArchiveView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchiveView()
//    }
//}
