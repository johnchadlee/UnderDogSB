//
//  AuthView.swift
//  UnderDog Prototype
//
//  Created by John Lee on 3/11/21.
//
import UIKit
import SwiftUI

//#if (arm64)
struct signUpView : View {
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    @State var email: String = ""
    @State var displayName: String = ""
    @State var state: String = "        "
    @State var error: String = ""
    @State var degrees = 0.0
    
    let states: [String] = ["Alabama",
            "Alaska",
            "Arizona",
            "Arkansas",
            "California",
            "Colorado",
            "Connecticut",
            "Delaware",
            "Florida",
            "Georgia",
            "Hawaii",
            "Idaho",
            "Illinois",
            "Indiana",
            "Iowa",
            "Kansas",
            "Kentucky",
            "Louisiana",
            "Maine",
            "Maryland",
            "Massachusetts",
            "Michigan",
            "Minnesota",
            "Mississippi",
            "Missouri",
            "Montana",
            "Nebraska",
            "Nevada",
            "New Hampshire",
            "New Jersey",
            "New Mexico",
            "New York",
            "North Carolina",
            "North Dakota",
            "Ohio",
            "Oklahoma",
            "Oregon",
            "Pennsylvania",
            "Rhode Island",
            "South Carolina",
            "South Dakota",
            "Tennessee",
            "Texas",
            "Utah",
            "Vermont",
            "Virginia",
            "Washington",
            "West Virginia",
            "Wisconsin",
            "Wyoming"]
    @EnvironmentObject var session: SessionStore

    var body: some View{
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            VStack{
            Image("newLogo")
                .resizable()
                .frame(width: 120, height: 120)
                .padding()
                .onTapGesture {
                    withAnimation {
                        self.degrees += 360
                    }
                }
                .rotation3DEffect(.degrees(degrees), axis: (x: 1, y: 0, z: 0))
            Text("may the odds be ever in your favor...")
                .foregroundColor(.secondary)
                .italic()
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    TextField("Username", text: $displayName)
                        .keyboardType(.default)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
//                        .cornerRadius(5.0)
                        .padding()
                    TextField("Email Address", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
//                        .cornerRadius(5.0)
                        .padding()
                    Picker(selection: $state, label: Text("State: \(state)")){
                            ForEach(states, id: \.self){
                                state in
                                Text(state).tag(state)
                    }}.pickerStyle(MenuPickerStyle())
                      .padding()
                      .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
//                      .cornerRadius(5.0)
                      .padding()
                }
            }.padding()
             .gesture(
                 TapGesture()
                     .onEnded { _ in
                         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                 }
             )
            if(UIScreen.main.bounds.height != 667){
                Spacer()
            }
            NavigationLink(destination: ageVerifyView(email: email, displayName: displayName, state: state) ) {Text( "Next")}
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                .disabled(email.isEmpty || displayName.isEmpty)
                .buttonStyle(largeButton() )
                .padding()
            if(error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            if(UIScreen.main.bounds.height == 667){
                Spacer()
            }
            }
    }
    }
}

struct ageVerifyView: View {
    @State var age: Int = 0
    @State var email: String = ""
    @State var displayName: String = ""
    @State var state: String = ""
    @State private var color = Color.red
    @State private var calcAge: DateComponents = DateComponents()
    @State private var activeLink: Bool = false;
    @State var showAlert: Bool = false;
    @State private var underage: Bool = true;
    @EnvironmentObject var session: SessionStore

    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
    @State private var birthDate = Date()
    
    var body: some View {
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            VStack{
        VStack(alignment: .center, spacing: 20){
            Text("Enter Your Birthday")
                .font(.custom("NotoSans-Medium", size: 22))
                .foregroundColor(Color.darkOceanBlue)
            Text("Users must be at least 18 years old to play and, in some states, users are required to be older")
                .font(.custom("NotoSans-Medium", size: 15))
                .foregroundColor(Color.gray)
                .padding()
        }
        VStack{
            DatePicker("",selection: $birthDate, displayedComponents: [.date])
                .datePickerStyle(WheelDatePickerStyle())
                .clipped()
                .labelsHidden()
        }.onChange(of: birthDate, perform: { value in
            calcAge = Calendar.current.dateComponents([.year, .month, .day], from: birthDate, to: Date())
            age = calcAge.year ?? 0
            if(age > 20){
                self.underage = false;
                self.activeLink = true
            }else{
                self.activeLink = false;
                self.underage = true;
            }
        })
        Text("Your Age: \(calcAge.year ?? 0)")
            .bold()
            .foregroundColor(age < 21 ? Color.red : Color.blue)
            .padding()
        Spacer()
        if(underage == false){
            NavigationLink(destination: preferenceView(email: email, displayName: displayName, state: state, age: age)) {
                                    Text("Next")
            }.background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
            .buttonStyle(largeButton() )
             .padding()
        }
//         .alert(isPresented: $showAlert) {
//                   Alert(title: Text("User Underage"), message: Text("Please comeback when you are above the age of 20"), dismissButton: .default(Text("Dismiss").foregroundColor(.black)))
//          }
        if(UIScreen.main.bounds.height == 667){
            Spacer()
        }
            }
    }
    }
}

struct preferenceView: View{
    @State var email: String = ""
    @State var displayName: String = ""
    @State var state: String = ""
    @State var age: Int = 0
    @State var NFL: Bool = false
//    @State var AFL: Bool = false
    @State var MLB: Bool = false
    @State var NBA: Bool = false
    @State var NHL: Bool = false
    @State var NCAAF: Bool = false
//    @State var Euroleague: Bool = false
//    @State var MMA: Bool = false
//    @State var NRL: Bool = false
    @State var EPL: Bool = false
    @State var MLS: Bool = false
    @State var SERIEA: Bool = false
    @State var LALIGA: Bool = false
    @State var UEFA: Bool = false
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    
    var body: some View {
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
        VStack(alignment: .center, spacing: 10){
            Text("Preference")
                .font(.custom("NotoSans-Medium", size: 22))
                .foregroundColor(Color.darkOceanBlue)
                .padding()
            Text("Select your prefered sports to get bets that make sense for you")
                .font(.custom("NotoSans-Medium", size: 15))
                .foregroundColor(Color.gray)
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
                Spacer()
                Spacer()
            }
            NavigationLink(destination: confirmPasswordView(email: email, displayName: displayName, state: state, age: age, NFL: NFL, MLB: MLB, NBA: NBA, NHL: NHL, NCAAF: NCAAF, EPL: EPL, MLS: MLS, SERIEA: SERIEA, LALIGA: LALIGA, UEFA: UEFA)) {
                                    Text("Next")
            }
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
            .buttonStyle(largeButton())
            .padding()
            if(UIScreen.main.bounds.height == 667){
                Spacer()
            }
        }
    }
    }
}

struct CheckboxStyle: ToggleStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
 
        return HStack {
 
            configuration.label
 
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(configuration.isOn ? .purple : .gray)
                .font(.system(size: 10, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
 
    }
}

struct confirmPasswordView: View {
    @State var password: String = ""
    @State var rpassword: String = ""
    @State var email: String = ""
    @State var displayName: String = ""
    @State var state: String = ""
    @State var age: Int = 0
    @State var error: String = ""
    @State var score: [Double] = [1000] //Free money
    @State var NFL: Bool = false
//    @State var AFL: Bool = false
    @State var MLB: Bool = false
    @State var NBA: Bool = false
    @State var NHL: Bool = false
    @State var NCAAF: Bool = false
//    @State var Euroleague: Bool = false
//    @State var MMA: Bool = false
//    @State var NRL: Bool = false
    @State var EPL: Bool = false
    @State var MLS: Bool = false
    @State var SERIEA: Bool = false
    @State var LALIGA: Bool = false
    @State var UEFA: Bool = false
    
    
    @State var profile: UserProfile?
    @State var preference: preference?
    @EnvironmentObject var session: SessionStore
    
    func signUp() {
        session.signUp(email: email, password: password, displayName: displayName, State: state, age: age, score: score, NFL: NFL, MLB: MLB, NBA: NBA, NHL: NHL, NCAAF: NCAAF, EPL: EPL, MLS: MLS, SERIEA: SERIEA, LALIGA: LALIGA, UEFA: UEFA) { (profile, preference, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.profile = profile
                print(profile!)
                self.email = ""
                self.password = ""
                self.preference = preference
            }
        }
    }
    // look into inserting optional tutorial here
    var body: some View {
        
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            VStack{
        Text("If you need a tutorial in sports betting, you can check out our tutorial in the account settings") .foregroundColor(.primary)
            .frame(width: 350, height: 100, alignment: .center)
            .font(.custom("NotoSans-Medium", size: 20))
            .multilineTextAlignment(.center)
            .padding()
        VStack{
            VStack(alignment: .leading, spacing: 18){

                TextField("Password", text: $password)
                    .keyboardType(.default)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
//                    .cornerRadius(5.0)
                    .padding()
                SecureField("Re-enter Password", text: $rpassword)
                    .keyboardType(.default)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
//                    .cornerRadius(5.0)
                    .padding()
            }
        }.padding()
         .gesture(
             TapGesture()
                 .onEnded { _ in
                     UIApplication.shared.sendAction(#selector(UIResponder .resignFirstResponder), to: nil, from: nil, for: nil)
             }
         )
        Spacer()
        if(UIScreen.main.bounds.height == 667){
            Spacer()
        }
        Button(action: signUp) {Text( "Sign Up")}
            .disabled(password != rpassword)
            .buttonStyle(largeButton() )
            .padding()
        if(error != "") {
            Text(error)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.red)
                .padding()
        }
        if(UIScreen.main.bounds.height == 667){
            Spacer()
        }
            }
    }
    }
}


struct loginView : View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var profile: UserProfile?
    @State var pref: preference?
    @EnvironmentObject var session: SessionStore
    @State var degrees = 0.0
    func login() {
        session.signIn(email: email, password: password) { (profile, pref, error) in
            if let error = error {
                self.error = error.localizedDescription
                print("Error when signing in: \(error)")
            } else {
//                self.email = ""
//                self.password = ""
                self.profile = profile
                self.pref = pref
            }
            
        }
    }
    var body: some View{
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            VStack{
        Image("newLogo")
            .resizable()
            .frame(width: 120, height: 120)
            .onTapGesture {
                withAnimation {
                    self.degrees += 360
                }
            }
            .rotation3DEffect(.degrees(degrees), axis: (x: 1, y: 0, z: 0))
            .padding()
        VStack(alignment: .leading, spacing:5){
            TextField("Email Address", text: $email)
                .autocapitalization(.none)
                .padding()
//                .background(Color("lightgrey"))
                .background(
                    RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
//                .cornerRadius(5.0)
                .padding()
            SecureField("Password", text: $password)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
//                .cornerRadius(5.0)
                .padding()
            NavigationLink(
                destination: resetPasswordView(),
                label: {
                    Text("Forget password?").foregroundColor(.blue)
                })
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                .padding()
                
        }
        .gesture(
            TapGesture()
                .onEnded { _ in
                    UIApplication.shared.sendAction(#selector(UIResponder .resignFirstResponder), to: nil, from: nil, for: nil)
            }
        )
        .padding(.horizontal)
        .padding(.vertical, 34)
        if(UIScreen.main.bounds.height != 667){
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        Spacer()
        Button(action: login) { Text("Login") }
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
            .buttonStyle(largeButton())
            .padding(.horizontal, 30)
        
        if(error != "") {
            Text(error)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.red)
                .padding()
        }
        if(UIScreen.main.bounds.height == 667){
            Spacer()
        }
            }
    }
    }
}

struct LaunchView: View {
    @State var shortString = true
    @State var degrees = 0.0
    var body: some View {
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
            VStack(alignment: .center, spacing: 25){
                Image("newBannerLogo")
                    .resizable()
                    .frame(width: 300.0, height: 150.0)
                    .onTapGesture {
                        withAnimation {
                            self.degrees += 360
                        }
                    }
                    .rotation3DEffect(.degrees(degrees), axis: (x: 1, y: 0, z: 0))
                TextAnimation()
                Spacer()
                NavigationLink(destination: signUpView(), label: {Text( "Sign Up")} )
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                NavigationLink(destination: loginView(), label: {Text( "Login")} )
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
            }
                .buttonStyle(largeButton())
                .padding()
            if(UIScreen.main.bounds.height == 667){
                Spacer()
            }
        }
    }
}

public struct TextAnimation: View {

    public init(){ }
    @State var text: String = ""
    public var body: some View {
      VStack{
        Text(text)
            .animation(.spring())
            .foregroundColor(.neonOceanBlue)
            .frame(width: 200, height: 100, alignment: .center)
            .font(.system(size: 20))
//            .multilineTextAlignment(.center)
      }.onAppear() {
          text = ""
          "Starting the Ralli one bet at a time.".enumerated().forEach { index, character in
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
              text += String(character)
            }
          }
      }
    }
}


struct resetPasswordView : View {
    @State private var emailSent = false
    @State var email: String = ""
    @EnvironmentObject var session: SessionStore
    func resetPassword() {
        session.resetPassword(email: email)
        emailSent = true
    }
    var body: some View {
        ZStack{
            Color.Neumorphic.main.ignoresSafeArea()
        if emailSent != false {
            VStack {
                Text("Check Your Email! If you haven't recieved a message from us, click the reset button again.")
                    .font(.custom("NotoSans-Medium", size: 18))
                    .foregroundColor(Color.gray)
                    .padding(.horizontal)
                    .padding()
            }
        }
        VStack (alignment: .center, spacing: 30){
            TextField("Email Address", text: $email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
//                .cornerRadius(5.0)
                .padding()
            Button(action: resetPassword, label: {
                Text("Reset")
                    .padding()
            })
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
            .buttonStyle(largeButton())
            Spacer()
        }
        }
    }
}


struct UpdatePasswordView: View {
    @State var currentPassword: String = ""
    @State var error: String = ""
    @State var email: String = ""
    @State var newPassword: String = ""
    @State private var showingAlert = false
    @State private var showSuccess = false
    @EnvironmentObject var session: SessionStore
    func changePassword() {
        session.changePassword(email: email, currentPassword: currentPassword, newPassword: newPassword)
            { (error) in
                if let error = error {
                    self.error = error.localizedDescription
                    print("Incorrect Email/Password: \(error)")      }
                else {
                    self.email = ""
                    self.currentPassword = ""
                    self.newPassword = ""
                    
                }}}
        var body: some View{
            ZStack{
                Color.Neumorphic.main.ignoresSafeArea()
            VStack(spacing: 15){
            Text("Update Password")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()
            TextField("Email Address", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
//                .cornerRadius(5.0)
                .padding()
            TextField("Current Password", text: $currentPassword)
                .keyboardType(.default)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
//                .cornerRadius(5.0)
                .padding()
            SecureField("New Password", text: $newPassword)
                .keyboardType(.default)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20)))
//                .cornerRadius(5.0)
                .padding()
            NavigationLink(
                    destination: resetPasswordView(),
                    label: {
                        Text("Forget password?")
                    })
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow())
                    .padding(.horizontal)
                Button("Change Password"){if(error != ""){ showingAlert = true;}
                else {
                    changePassword();
                    showSuccess = true;
                }}.softButtonStyle(Capsule(), pressedEffect: .flat)
                    .padding()
                      //  Text("Incorrect Email/Password")
                        //    .font(.system(size: 14, weight: .semibold))
                          //  .foregroundColor(.red)
                           // .padding()

            .buttonStyle(largeButton())
            .frame(maxHeight: .infinity,
              alignment: .top)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Incorrect Email/Password"), message: Text("Please Enter the Correct Email/Password"), dismissButton: .default(Text("Dismiss").foregroundColor(.black)))
            }
                
            }
             .gesture(
                 TapGesture()
                     .onEnded { _ in
                         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                 }
             )
            .alert(isPresented: $showSuccess) {
                Alert(title: Text("Password Updated!"), message: Text("Please return to the app"), dismissButton: .default(Text("Dismiss").foregroundColor(.black)))
            }
            }
        }
}

struct AuthView: View {
    var body: some View {
        NavigationView{
            LaunchView()
        }
    }
}

struct largeButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
//            .overlay(
//                RoundedRectangle(cornerRadius: 20).fill(Color("Button Color")).softInnerShadow(RoundedRectangle(cornerRadius: 20))
//            )
        .foregroundColor(Color.white)
        .frame(maxWidth: 350, minHeight: 44)
        .cornerRadius(6)
        .background(Color("Button Color"))
        .clipShape(Capsule())
        .overlay(Capsule()
                .stroke(Color("Button Color"), lineWidth: 1))
//                .scaleEffect(configuration.isPressed ? 1.1 : 1)
//                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        .font(.custom("NotoSans-Medium", size: 18))
        .opacity(configuration.isPressed ? 0.7 : 1)
        //RoundedRectangle(cornerRadius: 6)
    }
}
//#endif
