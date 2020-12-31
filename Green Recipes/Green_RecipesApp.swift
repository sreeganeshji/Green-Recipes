//
//  Green_RecipesApp.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/30/20.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct Green_RecipesApp: App {
    
    init(){
        
        //initialize photo data stores
        print("Configuring Amplify framework")
        
        do{
            Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.configure()
        }
        catch{
            print("could'nt configure due to error: \(error)")
        }
    }
    var data = DataModels()
    var body: some Scene {
        WindowGroup {
//            RecipesHome(recipies: .constant(.init(repeating: .init(name:"name",description:"Des"), count: 20)))
            
            HomePage().environmentObject(data)
        }
    }
}
