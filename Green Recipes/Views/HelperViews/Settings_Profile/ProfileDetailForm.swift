//
//  ProfileDetailForm.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/3/21.
//

import SwiftUI

struct ProfileDetailForm: View {
    @Binding var user:User
    var body: some View {
        Form{
            Section(header:HStack{
                Text("Username")
                Text("(Visible to everyone)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }){
        Text(user.username)
            .foregroundColor(.blue)

            }
            
            Section(header:Text("First Name")){
                Text(user.firstName).foregroundColor(.blue)
            }
            
            Section(header:Text("Last Name"))
            {
                Text(user.lastName)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct ProfileDetailForm_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailForm(user:.constant(.init()))
    }
}
