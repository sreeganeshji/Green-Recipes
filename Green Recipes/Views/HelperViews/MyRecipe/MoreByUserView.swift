//
//  MoreByUserView.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/7/21.
//

import SwiftUI

struct MoreByUserView: View {

    @State var showSheet = false
    @EnvironmentObject var data: DataModels
    @State var userRecipes :[RecipeTemplate1] = []
    @Binding var signedin:Bool

    var username :String
    var userid :Int
    
    var body: some View {
        Form{
                ForEach(self.userRecipes, id:\.self){
                    recipe in
                    NavigationLink(destination:RecipeDetail(id: recipe.id, signedin: $signedin, title: recipe.name).environmentObject(self.data))
                    {
                        HStack{
                        Text(recipe.name)
                            Spacer()
                            
                            if(checkFavorite(recipe: recipe)){
                                Button(action: {self.data.removeFavorites(userId: self.userid, recipe: recipe)}){
                                Image(systemName: "star.fill")
                                    .foregroundColor(.blue)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            else{
                                Button(action:{self.data.createFavorites(userId: self.userid, recipe: recipe)}){
                                    Image(systemName: "star")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(PlainButtonStyle())
                          
                            }
                        }
                           
                        }
                    }
                }
//            }
        
        .navigationTitle("More by \(username)")

        .onAppear(){
            fetchUserRecipes()
        }
    }
    
    func fetchUserRecipes(){
        func updateRecipes(recipes:[RecipeTemplate1], err:Error?){
            if err != nil{
                return
            }
            self.userRecipes = recipes
        }
        
        self.data.networkHandler.fetchMyRecipes(userId: self.userid, completion: updateRecipes)
    }
    
    func checkFavorite(recipe:RecipeTemplate1)->Bool{
        return self.data.cache.favRecipes.contains(recipe)
    }
}


//struct MoreByUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//        MoreByUserView(navigationTitle: .constant("My Recipes")).environmentObject(DataModels())
//        }
//    }
//}
