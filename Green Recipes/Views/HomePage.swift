//
//  HomePage.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/30/20.
//
/*
 
 */

import SwiftUI
import AuthenticationServices

enum tabViews {
    case search, settings, favorites, explore, addRecipe
    /*
     * explore- can be category wise arrangement of the popular dishes based on views this week, last week and so on. We'll figure out.
     */
}

struct HomePage: View {
    @State var signedIn:Bool = false
    @EnvironmentObject var data:DataModels
    @State var tabSelect:tabViews = tabViews.explore
    
    @State var signUp:Bool = false
    
    var body: some View {
        if(self.signedIn){
        TabView(selection: $tabSelect) {
            Text("Explore").tabItem { HStack{
                Image(systemName: "sparkles")
                Text("Explore")
            } }.tag(tabViews.explore)
            
            SearchView()
                .tabItem { HStack{
                Image(systemName: "magnifyingglass")
                Text("Search")} }.tag(tabViews.search)
            Text("Favorites").tabItem { HStack{
                Image(systemName: "star.fill")
                Text("Favorites")} }.tag(tabViews.favorites)
            
                AddRecipe().environmentObject(data)
                    .tabItem {
                        HStack{
                            Image(systemName: "tray.fill")
                            Text("My Recipes")} }.tag(tabViews.addRecipe)

            Text("Settings").tabItem { HStack{
                Image(systemName: "gear")
                Text("Settings")} }.tag(tabViews.settings)
        }
        }
        else if(self.signUp){
            SignUp(user: self.data.user).environmentObject(data)
        }
        else{
SignInWithAppleButton(
        onRequest: { request in
            request.requestedScopes = [.fullName,.email]
        },
        onCompletion: { result in
            switch(result){
            
            case .success(let authResults):
                if let details = authResults.credential as? ASAuthorizationAppleIDCredential{
                    let userid = details.user
              
                    let email = details.email
                    let identityToken = details.identityToken
                    let authcode = details.authorizationCode
                    let givenName = details.fullName?.givenName
                    let familyName = details.fullName?.familyName
                    let state = details.state
                    /*
                     Find the user in the database, if not found create a new user and add to the database.
                     if found, retrive their information.
                     */
                    // send a user object to the backend server
                    var sessionUser = User()
                    
                    sessionUser.appleId = userid
                    sessionUser.email = email
                    sessionUser.firstName = givenName ?? ""
                    sessionUser.lastName = familyName ?? ""
                    
                    
                    data.user = data.networkHandler.fetchUser(user: sessionUser)
                    
                    
                    print("userid",userid,"email",email,"identityToken",identityToken,"authcode",authcode?.base64EncodedString(),"name",details.fullName?.description,"givenName",givenName,"familyName",familyName,"state",state)
                    
                    //Find if the user exists
                    print("Userid",userid.description)
                    self.data.networkHandler.getUserWithAppleID(appleID: userid.description, completion: updateUser)
                    
                }
            case .failure(let error):
                print("Failed",error)
                self.signedIn = false
            }
        }
    ).padding()
                    .frame(height:100)
//            .signInWithAppleButtonStyle(.)

    }

    }
    
    func updateUser(user:User){
        self.data.user = user
        if self.data.user.username == ""{
            self.signUp = true
            return
        }
        self.signedIn = true
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(DataModels())
    }
}
