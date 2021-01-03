//
//  FavoritesView.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/24/20.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var data:DataModels
    @State var navigationTitle:Binding<String>
    
    var body: some View {
     
            List{
            ForEach(self.data.cache.favRecipes.sorted(by: { (r1, r2) -> Bool in
                return (r1.id<r2.id)
            }), id:\.id){
                recipe in
                
                NavigationLink(destination: RecipeDetail(id: recipe.id).environmentObject(self.data)){
                    HStack{
                Text(recipe.name)
                        Spacer()
                        Button(action:{self.data.removeFavorites(userId: self.data.user.userId, recipe: recipe)}){
                            Image(systemName: "star.slash")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }

            }
            .navigationTitle("Favorites")
            .navigationBarTitle("Whats this?")
            .onAppear(){
                self.navigationTitle.wrappedValue = "Favorites"
            }
            
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            FavoritesView(navigationTitle: .constant("Stuff")).environmentObject(DataModels())
        }
    }
}
