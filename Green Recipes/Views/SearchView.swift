//
//  SearchView.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 12/19/20.
//

import SwiftUI

struct SearchView: View {
    @State var text : String = ""
    @State var recipes : [RecipeTemplate1] = []
    @EnvironmentObject var data:DataModels
    var body: some View {
        VStack{
            HStack{
                Button(action: searchQuery){
                Image(systemName: "magnifyingglass")
                }
                
                TextField("Search recipes", text: $text)
                
                Button(action:clearSearchField){
                Image(systemName: "xmark.circle.fill")
                }
                
            }.padding()
            List{
                ForEach(self.recipes, id:\.self){
                    recipe in
                    HStack{
                        Text(recipe.name)
                    }
                }
            }
        }
    }
    func clearSearchField(){
        self.text = ""
    }
    
    func searchQuery(){
        data.networkHandler.searchRecipeLike(text: self.text, completion: updateRecipes)
        print("Recipes recived are ", self.recipes)
    }
    
    func updateRecipes(recipes:[RecipeTemplate1]){
        self.recipes = recipes
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(DataModels())
    }
}
