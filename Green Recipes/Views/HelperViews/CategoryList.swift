//
//  CategoryList.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/12/21.
//

import SwiftUI

struct CategoryList: View {
    var categoryName:String
    @State var recipes:[RecipeTemplate1] = []
    @EnvironmentObject var data:DataModels
    @State var text = ""
    @State var loading = true
    @Binding var signedin:Bool
    var body: some View {
        if loading{
            VStack{
            Text("Loading")
                .foregroundColor(.blue)
                .font(.title)
                .fontWeight(.light)
                
                activityIndicator()
                    .onAppear(){
                        searchQuery()
                    }
            }
        }
        else{
        List{
            SearchBarUI(text:$text, completion: searchQuery)
                
                ForEach(self.recipes, id:\.self){
                    recipe in
                    
                    NavigationLink(destination:RecipeDetail(id: recipe.id, signedin: $signedin, title: recipe.name).environmentObject(self.data))
                    {
                        HStack{
                        Text(recipe.name)
                            Spacer()
                            Text(String(format: "%0.1f",recipe.rating ?? 0)).font(.footnote)
                                .padding(-3)
                            Image(systemName: "star.fill").foregroundColor(.yellow).font(.footnote)
                                .padding(-3)
                            Text(String("(\(recipe.ratingCount ?? 0))")).font(.footnote)
                                .padding(EdgeInsets(top: -3, leading: -3, bottom: -3, trailing: 0))
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
                }
        }
        .navigationBarTitle(categoryName)
        }
    }
    func updateRecipes(recipes:[RecipeTemplate1], error:Error?){
        loading = false
        if error != nil{
            print("Error fetching recipes: \(error)")
            return
        }
        self.recipes = recipes

    }
    
    func searchQuery(){
        //search category
        if text == ""{
        data.networkHandler.fetchRecipesOfCategory(category: categoryName, completion: updateRecipes)
            return
        }
        
        data.networkHandler.searchRecipeCategory(category: categoryName, text: text, count: 50, completion: updateRecipes)

    }
    
    func checkFavorite(recipe:RecipeTemplate1)->Bool{
        return self.data.cache.favRecipes.contains(recipe)
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList(categoryName: "Lunch", signedin: .constant(true)).environmentObject(DataModels())
    }
}
