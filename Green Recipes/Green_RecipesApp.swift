//
//  Green_RecipesApp.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/30/20.
//

import SwiftUI

@main
struct Green_RecipesApp: App {
    var data = DataModels()
    var body: some Scene {
        WindowGroup {
//            RecipesHome(recipies: .constant(.init(repeating: .init(name:"name",description:"Des"), count: 20)))
            AddRecipe().environmentObject(data)
        }
    }
}
