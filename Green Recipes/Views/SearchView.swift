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
    
    //modal sheet
    @State var sheetPresented = false
    @State var sheetRecipeID = 0
    var body: some View {
        
        List{
          
//            HStack{
//                Button(action: searchQuery){
//                Image(systemName: "magnifyingglass")
//                }
//
//                TextField("Search recipes", text: $text)
//
//                Button(action:clearSearchField){
//                Image(systemName: "xmark.circle.fill")
//                }
//
//            }.padding()
            
            SearchBarUI(text:$text, completion: searchQuery)
                
        
//            Form{
                ForEach(self.recipes, id:\.self){
                    recipe in
                    
//                    Button(action:{
//                        print("Sending id \(recipe.id)")
//                        self.sheetRecipeID = recipe.id
//                        self.sheetPresented = true
//                    })
                    NavigationLink(destination:RecipeDetail(id: recipe.id, title: recipe.name).environmentObject(self.data))
                    {
                        HStack{
                        Text(recipe.name)
                            Spacer()
                            
                            if(checkFavorite(recipe: recipe)){
                                Button(action: {self.data.removeFavorites(userId: self.data.user.userId, recipe: recipe)}){
                                Image(systemName: "star.fill")
                                    .foregroundColor(.blue)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            else{
                                Button(action:{self.data.createFavorites(userId: self.data.user.userId, recipe: recipe)}){
                                    Image(systemName: "star")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(PlainButtonStyle())
                          
                            }
                        }
                    }
//                    .listRowInsets(EdgeInsets())
                }
//            }
            
        }
//        .navigationBarHidden(true)
        
        .navigationTitle("Search Recipes")
        
        
//        .sheet(isPresented: self.$sheetPresented, content: {
//            RecipeDetail(id: self.sheetRecipeID)
//        })
   
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
    
    func checkFavorite(recipe:RecipeTemplate1)->Bool{
        return self.data.cache.favRecipes.contains(recipe)
    }
    
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(DataModels())
    }
}
