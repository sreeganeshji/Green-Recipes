//
//  ProfileDetail.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/3/21.
//

import SwiftUI

struct ProfileDetail: View {
    @EnvironmentObject var data:DataModels
    @State var user:User = .init()
    @Environment(\.editMode) var editmode
    var body: some View {
        VStack{
        if (editmode?.wrappedValue == EditMode.active)
        {
            ProfileEditView(user:$user)
        }
        else{
            Text("Not Editing")
        }
    }
        .navigationBarItems(trailing: EditButton().font(.headline))
    }
}

struct ProfileDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetail()
    }
}
