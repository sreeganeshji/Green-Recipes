//
//  SignUp.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/21/20.
//

import SwiftUI

struct SignUp: View {
    @State var user:User
    
    @EnvironmentObject var data:DataModels
    var body: some View {
        NavigationView{
            Form
            {
                Section{
                HStack{
                    Text("Username:").bold()
                    TextField("", text: self.$data.user.username)
                }
                HStack{
                    Text("Firstname:").bold()
                    TextField("", text: self.$data.user.firstName)
                }
                HStack{
                    Text("Lastname:").bold()
                    TextField("", text: self.$data.user.lastName)
                }
                }
                Button(action:{}){
                    HStack{
                        Spacer()
                    Text("Submit")
                        Spacer()
                    }
                }
        }
        .navigationTitle("SignUp")
    }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(user: .init()).environmentObject(DataModels())
    }
}
