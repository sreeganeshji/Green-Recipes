//
//  Settings.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/30/20.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var data:DataModels
    @State var username:String = ""
    @Binding var signedin:Bool
    var body: some View {
        Form{
            Section{
                if data.user.appleId == ""{
                    Button(action:{signedin = false})
                    {
                        Text("Sign In")
//                            .font(.title)
//                            .fontWeight(.light)
                    }
                }
                else{
                NavigationLink(destination:ProfileDetail().environmentObject(self.data)
                                .onDisappear(){
                                    username = data.user.username
                                }
                )
                {
                    Text(username)
                        .font(.title2)
                }
                }
            }
            Section{
                NavigationLink(destination:PrivacyPolicy()){
                    Text("Privacy Policy")
                }
            }
            
        }
        .onAppear(){
            username = data.user.username
        }
            .navigationTitle("Settings")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(signedin: .constant(true)).environmentObject(DataModels())
    }
}
