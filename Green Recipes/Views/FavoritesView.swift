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
    @State var loading = false
    @Binding var signedin :Bool
    var body: some View {
   
            if loading{
                Text("Loading...")
                    .foregroundColor(.blue)
                    .font(.title)
                    .fontWeight(.light)
                    
                    activityIndicator()
                    .navigationTitle("Favorites")

            }
            else if (data.user.appleId == ""){
                Button(action:{signedin = false})
                {
                    Text("Sign In")
                        .foregroundColor(.blue)
                        .font(.title)
                        .fontWeight(.light)
                }
                .navigationTitle("Favorites")
            }
            else if (data.cache.favRecipes.count == 0){
                Text("No favorites yet.")
                    .navigationTitle("Favorites")
            }
            else{
                
            List{
            ForEach(self.data.cache.favRecipes.sorted(by: { (r1, r2) -> Bool in
                return (r1.id<r2.id)
            }), id:\.id){
                recipe in
                
                NavigationLink(destination: RecipeDetail(id: recipe.id, title: recipe.name).environmentObject(self.data)){
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
            .onAppear(){
                self.navigationTitle.wrappedValue = "Favorites"
            }
            }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            FavoritesView(navigationTitle: .constant("Stuff"), signedin: .constant(true)).environmentObject(DataModels())
        }
    }
}
