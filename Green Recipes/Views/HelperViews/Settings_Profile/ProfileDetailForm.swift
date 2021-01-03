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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProfileDetailForm_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailForm(user:.constant(.init()))
    }
}
