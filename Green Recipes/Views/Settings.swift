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
    var body: some View {
        Form{
            Section{
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
        .onAppear(){
            username = data.user.username
        }
            .navigationTitle("Settings")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(DataModels())
    }
}
