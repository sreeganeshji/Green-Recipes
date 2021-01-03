//
//  Settings.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/30/20.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var data:DataModels
    var body: some View {
        Form{
            Section{
                NavigationLink(destination:ProfileDetail().environmentObject(self.data))
                {
                    Text("\(self.data.user.username)")
                        .font(.title2)
                }
            }
        }
            .navigationTitle("Settings")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(DataModels())
    }
}
