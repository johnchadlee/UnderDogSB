import Foundation
import SwiftUI
import Firebase
import UIKit
import FirebaseDatabase

//#if (arm64)
struct SportsBetting101View: View {
    @EnvironmentObject var session: SessionStore
    @Environment(\.colorScheme) var colorScheme
    @State var numberOfTut = 12
    var body: some View{
        if(colorScheme == .dark){
        TabView{
            ForEach(1..<numberOfTut) {   num in
                Image("tut\(num)")
                    .resizable()
                    .scaledToFit()
                    .tag(num)
            }
            }
        .tabViewStyle(PageTabViewStyle())
                .padding()
        }
            else{
                TabView{
            ForEach(1..<numberOfTut) {   num in
                Image("tut\(num)")
                    .resizable()
                    .scaledToFit()
                    .tag(num)
            }
            }
            .tabViewStyle(PageTabViewStyle())
            .padding()
    }
}
}
                
// Edit to Add as CheckBox
struct SportsBettingYNView: View{
    @EnvironmentObject var session: SessionStore
    var body: some View {
        VStack(spacing: 30){
        Text("Would you like a quick introduction to sports betting ?")
            .padding()
        NavigationLink(destination: SportsBetting101View()) {Text( "Yes")}
            .buttonStyle(largeButton())
        NavigationLink(destination: LoggedInView()) {Text("Skip")}
        } .font(.system(size: 20, weight: .bold, design: .rounded))
        .frame(maxHeight: .infinity,
          alignment: .top)
    }
}

struct ContactSupportView: View {
    @EnvironmentObject var session: SessionStore
    @State var email: String = ""
    @State var issue: String = ""
    @State var error: String = ""
    @State private var showAlert = false
    
    func createHelpTicket(){
        let db = Firestore.firestore()
        db.collection("HelpTicket").document(email).setData([
            "email": email,
            "issue": issue
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        self.showAlert = true
    }
    
    var body: some View {
        VStack(spacing:30){
            Text("Contact Support")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()
            TextField("Email Address", text: $email)
                .padding()
            TextField("Issue", text: $issue).padding()
            Button("Submit Issue")  {
                createHelpTicket()
            }
            .alert(isPresented: self.$showAlert) {
                Alert(title: Text("We Got You!"), message: Text("Your Request has been submitted"), dismissButton: .default(Text("Got it!")))
            }
            .frame(maxHeight: .infinity,
              alignment: .top)
            .buttonStyle(largeButton())
            .padding()
        }
    }
}

struct DarkModeView: View {
    @EnvironmentObject var session: SessionStore
    var body: some View{
        VStack{
            Text("Dark Mode")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()
            Toggle(isOn: $session.isDarkMode, label: {
                Text("Dark Mode")
            }).padding()
        }
        .preferredColorScheme(session.isDarkMode ? .dark : .light)
        .accentColor(.primary)
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        }
}
//#endif
