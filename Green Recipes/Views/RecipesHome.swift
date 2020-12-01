//
//  RecipesHome.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/31/20.
//Lists all the recipes based on search results and so on.
//go into the detailed view of the selected recipe.

import SwiftUI

struct RecipesHome: View {
    var rows:[GridItem] = .init(repeating: .init(.fixed(30)), count: 2)
   @Binding var recipies:[Recipe]
    var body: some View {
        ScrollView(.horizontal){
        LazyHGrid(rows: rows) /*@START_MENU_TOKEN@*/{
            ForEach(recipies,id:\.self){
                recipie in
                recipieThumb1(recipe: .constant(recipie))
            }
        }/*@END_MENU_TOKEN@*/
        }
    }
}

struct RecipesHome_Previews: PreviewProvider {
    static var previews: some View {
        RecipesHome(recipies: .constant([ Recipe(name: "Vada Puri", description: "Masala recipe for making the best donout"),]))
    }
}
