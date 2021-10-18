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

//#if (arm64)
struct UpdatePreferenceView: View {
    @EnvironmentObject var session: SessionStore
//    private var profileRepository = UserProfileRepository()
    @State var NFL: Bool = true
//    @State var AFL: Bool = true
    @State var MLB: Bool = true
    @State var NBA: Bool = true
    @State var NHL: Bool = true
    @State var NCAAF: Bool = true
//    @State var Euroleague: Bool = false
//    @State var MMA: Bool = false
//    @State var NRL: Bool = false
    @State var EPL: Bool = false
    @State var MLS: Bool = false
    @State var SERIEA: Bool = false
    @State var LALIGA: Bool = false
    @State var UEFA: Bool = false
    @State var error: String = ""
    @State var showingAlert = false
    @State var showSuccess = false

    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    func confirmUpdatedPref() {
        session.confirmUpdatedPref(NFL: NFL, MLB: MLB, NBA: NBA, NHL: NHL, NCAAF: NCAAF, EPL: EPL, MLS: MLS, SERIEA: UEFA, LALIGA: LALIGA, UEFA: SERIEA) { (preference, error) in
            if let error = error {
                self.error = error.localizedDescription
            }
        }
        if(error == ""){
            showSuccess = true;
        }else{
            showingAlert = true;
        }
    }

    var body: some View {
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
        VStack(alignment: .center, spacing: 10){
            Spacer()
            Text("Update Your Preference")
                .font(.custom("NotoSans-Medium", size: 22))
                .foregroundColor(.primary)
                .padding()
            VStack{
            Menu{
                Menu{
                    Toggle(isOn: $NFL, label: {
                        Text("NFL 🇺🇸")
                    })
                    .padding()
                    Toggle(isOn: $NCAAF, label: {
                        Text("NCAAF 🇺🇸")
                    })
                }label: {
                    Text("Football 🏈")
                }
                Menu{
                    Button("EPL 🇬🇧") {
                        EPL = true
                    }
                    Button("MLS 🇺🇸") {
                        MLS = true
                    }
                    Button("Serie A 🇮🇹") {
                        SERIEA = true
                    }
                    Button("La Liga 🇪🇸") {
                        LALIGA = true
                    }
                    Button("UEFA 🇪🇺") {
                        UEFA = true
                    }
                }label: {
                    Text("Soccer ⚽")
                }
                Menu{
                    Button("NBA 🇺🇸") {
                        NBA = true
                    }
//                    Button("Euro League 🇪🇺"){
//                        Euroleague = true
//                    }
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
//                Menu{
//                    Button("MMA 🥋") {
//                        MMA = true
//                    }
//                }label: {
//                    Text("MMA 🥋")
//               }
//                Menu{
//                    Button("NRL 🇦🇺") {
//                        NRL = true
//                    }
//                }label: {
//                    Text("Rugby 🏉")
//               }

            }label: {
                Label("Sports", systemImage: "sportscourt")
                    .accentColor(.blue)
                    .font(.system(size: 22, weight: .semibold))
           }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
            Spacer()
            ScrollView{
                LazyVGrid(columns: columns){
                    Toggle(isOn: $NFL, label: {
                        Text("NFL 🇺🇸")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $NCAAF, label: {
                        Text("NCAAF 🇺🇸")
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
//                    Toggle(isOn: $Euroleague, label: {
//                        Text("Euro League 🇪🇺")
//                    })
//                    .padding()
//                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $NHL, label: {
                        Text("NHL 🇺🇸")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
//                    Toggle(isOn: $MMA, label: {
//                        Text("MMA 🥋")
//                    })
//                    .padding()
//                    .toggleStyle(CheckboxStyle())
//                    Toggle(isOn: $NRL, label: {
//                        Text("NRL 🇦🇺")
//                    })
//                    .padding()
//                    .toggleStyle(CheckboxStyle())
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
                    Toggle(isOn: $UEFA, label: {
                        Text("UEFA 🇪🇺")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $LALIGA, label: {
                        Text("La Liga 🇪🇸")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $SERIEA, label: {
                        Text("Serie A 🇮🇹")
                    })
                    .padding()
                    .toggleStyle(CheckboxStyle())
                }
            }
            Button(action: confirmUpdatedPref, label: {
                Text("Confirm Changes").padding()
            }).softButtonStyle(RoundedRectangle(cornerRadius: 20))
            .buttonStyle(largeButton())
            Spacer()
        }
        .onAppear{
            let thisPref = session.pref
            NFL = thisPref!.NFL
//            AFL = thisPref!.AFL
            NCAAF = thisPref!.NCAAF
            MLB = thisPref!.MLB
            NBA = thisPref!.NBA
            NHL = thisPref!.NHL
//            Euroleague = thisPref!.Euroleague
//            MMA = thisPref!.MMA
//            NRL = thisPref!.NRL
            EPL = thisPref!.EPL
            MLS = thisPref!.MLS
            UEFA = thisPref!.UEFA
            SERIEA = thisPref!.SERIEA
            LALIGA = thisPref!.LALIGA
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Preference Update Failed!"), message: Text("Please contact us and submit a help ticket"), dismissButton: .default(Text("Dismiss").foregroundColor(.black)))
        }
        .alert(isPresented: $showSuccess) {
            Alert(title: Text("Preference Updated!"), message: Text("Please return to the app"), dismissButton: .default(Text("Dismiss").foregroundColor(.black)))
        }
        }
    }
}

struct UpdatePreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePreferenceView()
    }
}
//#endif
