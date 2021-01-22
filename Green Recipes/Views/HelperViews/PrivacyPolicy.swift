//
//  PrivacyPolicy.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/20/21.
//

import SwiftUI

struct PrivacyPolicy: View {
    var body: some View {
        ScrollView{
            Text("Last Updated: Jan 20, 2021").foregroundColor(.secondary)
                .font(.footnote)
            Text("Hello! Welcome to Your Recipe privacy policy. This policy describes how this iOS app collects, uses, and shares information about you.")
            Text("By downloading, accessing and using the Your Recipe app, you agree to the collection and use of your information in accordance with this privacy policy. If you have any other concerns about providing information to us or it being used as described in this Privacy Policy you should not use this app.")
            Text("Most of the data collected by Your Recipe comes from you such as recipes that you submit, optional images and other fields that you submit with the recipe. Reviews that you leave on other recipes. Your Recipe also collects your personal information such as First Name, Last Name, email and User Identifier from Sign in with Apple.")
            Text("You can also access this at")
            TextField("https://statichostganesh.s3-us-west-1.amazonaws.com/index.html", text: .constant("https://statichostganesh.s3-us-west-1.amazonaws.com/index.html")).foregroundColor(.blue)
                .font(.footnote)
        }.padding()
            .navigationTitle(Text("Privacy Policy"))
    }
}

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicy()
    }
}
