//
//  RecipeDetail.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/20/20.
//

import SwiftUI

struct RecipeDetail: View {
    @State var id :Int
    @State var recipe = Recipe()
    @EnvironmentObject var data:DataModels
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }


func GetRecipeByID(){
    
}

func UpdateRecipe(recipe:Recipe){
    
    self.recipe = recipe
}
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(id:1).environmentObject(DataModels())
    }
}
