//
//  VerifyCredentials.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/22/20.
//

import SwiftUI

struct VerifyCredentials: View {
    @Binding var showSheet:Bool
    @State var editUsername = true
    @Binding var user:User
    @EnvironmentObject var data:DataModels
    var body: some View {
        NavigationView{
        Form{
            Section{
            HStack{
                Text("Firstname:").bold()
                TextField("", text: $user.firstName)
            }
            HStack{
                Text("Lastname:").bold()
                TextField("", text: $user.lastName)
            }
            if(self.editUsername){
            HStack{
                Text("Username:").bold()
                TextField("", text: $user.firstName)
                Text("Visible to everyone").foregroundColor(.secondary)
            }
            }
            else{
                HStack{
                    Text("Username:").bold()
                    Text(user.username)
 
                }
            }
            }

        }
        .navigationTitle("Profile Details")
        .navigationBarItems(trailing: Button(action:{}){Text("Done")})
        }
    }

}

struct VerifyCredentials_Previews: PreviewProvider {
    static var previews: some View {
        VerifyCredentials(showSheet: .constant(true), user: .constant(User())).environmentObject(DataModels())
    }
}
