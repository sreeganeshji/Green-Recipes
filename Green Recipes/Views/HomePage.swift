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
    @State var userDB = User()
    @State var verifyCredentials = false
    @State var navigationTitle:String = "Green Recipe"
    
    
    var body: some View {

        if(self.signedIn){
            NavigationView{
        TabView(selection: $tabSelect) {
            Text("Explore").tabItem { HStack{
                Image(systemName: "sparkles")
                Text("Explore")
            } }.tag(tabViews.explore)
            
            SearchView()
                .tabItem { HStack{
                Image(systemName: "magnifyingglass")
                Text("Search")} }.tag(tabViews.search)
            
            FavoritesView(navigationTitle: self.$navigationTitle).environmentObject(self.data)
                .tabItem { HStack{
                Image(systemName: "star.fill")
                Text("Favorites")} }.tag(tabViews.favorites)
            
            MyRecipes(navigationTitle: self.$navigationTitle).environmentObject(data)
                .tabItem {
                HStack{
                Image(systemName: "tray.fill")
                Text("My Recipes")} }.tag(tabViews.addRecipe)

            Text("Settings").tabItem { HStack{
                Image(systemName: "gear")
                Text("Settings")} }.tag(tabViews.settings)
                }
        .navigationTitle(self.navigationTitle)
            }
        }

        else{
SignInWithAppleButton(.signIn, onRequest: { request in
    request.requestedScopes = [.fullName,.email]
//    request.nonce = "noncestr"
//    request.state = "statestr"
        
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
                    var appleID_clean = String(userid)
                    appleID_clean.removeAll { (c:Character) -> Bool in
                        if (c == "."){
                            return true
                        }
                        return false
                    }
                    
                    self.data.user.appleId = appleID_clean
                    self.data.user.email = email ?? ""
                    self.data.user.firstName = givenName ?? ""
                    self.data.user.lastName = familyName ?? ""
                    //default username
                    self.data.user.username = (givenName ?? "" )+" "+(familyName ?? "")
                        
                    self.userDB.appleId = appleID_clean
                    
                    
                    //check if user already existed.
                    
                    
                
                    
                    print("userid",userid,"email",email,"identityToken",identityToken,"authcode",authcode?.base64EncodedString(),"name",details.fullName?.description,"givenName",givenName,"familyName",familyName,"state",state)
                    
                    //Find if the user exists
                    print("Userid",userid.description)
                    self.data.networkHandler.getUserWithAppleID(appleID: appleID_clean, completion: updateUser)
                    
                }
            case .failure(let error):
                print("Failed",error)
                self.signedIn = false
            }
        }
    ).padding()
                    .frame(height:100)
.signInWithAppleButtonStyle(.whiteOutline)

    }
//        .sheet(isPresented: self.$verifyCredentials, content: {
//            VerifyCredentials(showSheet: self.$verifyCredentials, editUsername: true, user: self.$userDB).environmentObject(self.data)
//        })
     
    }
    
    func updateUser(user:User){
        self.userDB = user
        if self.userDB.firstName == ""{
            //new user. Create database entry from the apple credentials.
            
            //verify credentials
//            self.verifyCredentials = true
            
            //submit to database
            self.data.networkHandler.createUser(user: self.data.user, completion: createUser)
           
        }
        self.data.user = self.userDB
        self.signedIn = true
        
        //fetch favorites
        self.data.updateCache()
    }
    
    func createUser(user:User?, err:Error?){
        if err != nil{
            print("Error creating user: \(err)")
            return
        }
        if user != nil{
            self.userDB.copyFrom(user: user!)
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(DataModels())
    }
}
