//
//  ProfileEditView.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/3/21.
//

import SwiftUI

struct ProfileEditView: View {
    @Binding var user:User
    var body: some View {
        Form{
            
            Section(header:HStack{
                Text("Username")
                Text("(Visible to everyone)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }){
        TextField("Username", text: $user.username)

            }
            
            Section(header:Text("First Name")){
                TextField("First Name", text: $user.firstName)
            }
            
            Section(header:Text("Last Name"))
            {
                TextField("Last Name", text: $user.lastName)
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(user: .constant(.init()))
    }
}
