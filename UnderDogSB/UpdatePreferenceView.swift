//
//  UpdatePreferenceView.swift
//  UnderDog Prototype
//
//  Created by Oscar Gao on 5/5/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestoreSwift

struct UpdatePreferenceView: View {
    @EnvironmentObject var session: SessionStore
//    private var profileRepository = UserProfileRepository()
    
    @State var NFL: Bool = true
    @State var AFL: Bool = true
    @State var MLB: Bool = true
    @State var NBA: Bool = true
    @State var NHL: Bool = true
    @State var Euroleague: Bool = false
    @State var MMA: Bool = false
    @State var NRL: Bool = false
    @State var EPL: Bool = false
    @State var MLS: Bool = false
    @State var error: String = ""

    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    func confirmUpdatedPref() {
        session.confirmUpdatedPref(NFL: NFL, AFL: AFL, MLB: MLB, NBA: NBA, NHL: NHL, Euroleague: Euroleague, MMA: MMA, NRL: NRL, EPL: EPL, MLS: MLS) { (preference, error) in
            if let error = error {
                self.error = error.localizedDescription
            }
        }
    }

    var body: some View {

        VStack(alignment: .center, spacing: 10){
            Spacer()
            Text("Update Your Preference")
                .font(.custom("NotoSans-Medium", size: 22))
                .foregroundColor(Color.black)
                .padding()
            Menu{
                Menu{
                    Toggle(isOn: $NFL, label: {
                        Text("NFL 🇺🇸")
                    })
                    .padding()
                    Toggle(isOn: $AFL, label: {
                        Text("AFL 🇦🇺")
                    })
                }label: {
                    Text("Football 🏈")
                }
                Menu{
                    Button("EPL 🇬🇧") {
                        EPL = true
                    }
                }label: {
                    Text("Soccer ⚽")
                }
                Menu{
                    Button("NBA 🇺🇸") {
                        NBA = true
                    }
                    Button("Euro League 🇪🇺"){
                        Euroleague = true
                    }
                }label: {
                    Text("Basketball 🏀")
               }
                Menu{
                    Button("MLB 🇺🇸") {
                        MLB = true
                    }
                }label: {
                    Text("Baseball ⚾")
               }
                Menu{
                    Button("NHL 🇺🇸") {
                        NHL = true
                    }
                }label: {
                    Text("Ice Hockey 🏒")
               }
                Menu{
                    Button("MMA 🥋") {
                        MMA = true
                    }
                }label: {
                    Text("MMA 🥋")
               }
                Menu{
                    Button("NRL 🇦🇺") {
                        NRL = true
                    }
                }label: {
                    Text("Rugby 🏉")
               }

            }label: {
                Label("Sports", systemImage: "sportscourt")
                    .accentColor(.blue)
                    .font(.system(size: 22, weight: .semibold))
           }
            Spacer()
            ScrollView{
                LazyVGrid(columns: columns){
                    Toggle(isOn: $NFL, label: {
                        Text("NFL 🇺🇸")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $AFL, label: {
                        Text("AFL 🇦🇺")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $MLB, label: {
                        Text("MLB 🇺🇸")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $NBA, label: {
                        Text("NBA 🇺🇸")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $Euroleague, label: {
                        Text("Euro League 🇪🇺")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $NHL, label: {
                        Text("NHL 🇺🇸")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $MMA, label: {
                        Text("MMA 🥋")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $NRL, label: {
                        Text("NRL 🇦🇺")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $EPL, label: {
                        Text("EPL 🇬🇧")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $MLS, label: {
                        Text("MLS 🇺🇸")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                }
            }
            Button(action: confirmUpdatedPref, label: {
                Text("Confirm Changes").padding()
            })
            .buttonStyle(largeButton())

        }
        .onAppear{
            let thisPref = session.pref
            NFL = thisPref!.NFL
            AFL = thisPref!.AFL
            MLB = thisPref!.MLB
            NBA = thisPref!.NBA
            NHL = thisPref!.NHL
            Euroleague = thisPref!.Euroleague
            MMA = thisPref!.MMA
            NRL = thisPref!.NRL
            EPL = thisPref!.EPL
            MLS = thisPref!.MLS
        }
    }
}

struct UpdatePreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePreferenceView()
    }
}
