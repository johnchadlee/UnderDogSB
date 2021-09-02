////
////  SportsDB.swift
////  UnderDog Prototype
////
////  Created by John Lee on 6/2/21.
////
//
//import SwiftUI
//
//struct SportsDB: View {
//    
//    @State var DBgames = [[String: String?]]()
//    func getEvent(completion: @escaping ([[String: String?]]) -> () ) {
//        
//        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/1/searchevents.php?e=Denver_Nuggets_vs_Portland_Trail_Blazers") else {
//                print("Error: doesn't seem to be a valid URL")
//                return
//            }
//        URLSession.shared.dataTask(with: url) { (info, _, _) in
//            let DBgames = try! JSONDecoder().decode(Sportsdb.self, from: info!)
//            print(DBgames)
//            DispatchQueue.main.async {
//                completion(DBgames.event)
//            }
//        }
//        .resume()
//    }
//    var body: some View {
//        ForEach(DBgames){
//            dbGames in
//            print(dbGames)
//        }
////        Text("Hello World")
//        .onAppear(){
//            getEvent(){
//                dbGames in
//                DBgames = dbGames
//            }
//        }
//    }
//}
//
//struct SportsDB_Previews: PreviewProvider {
//    static var previews: some View {
//        SportsDB()
//    }
//}
