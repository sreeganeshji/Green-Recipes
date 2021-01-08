//
//  myRecipe.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 11/30/20.
//

import SwiftUI
/*
 Fetch my recipes and add new recipes.
 */

struct MyRecipes: View {
    @State var showSheet = false
    @EnvironmentObject var data: DataModels
    @State var navigationTitle:Binding<String>
    
    var body: some View {
        NavigationView{
        Form{
//            NavigationLink(destination:AddRecipe().environmentObject(self.data)){
////            HStack{
////                Text("Add recipe").bold()
////                Spacer()
////                Image(systemName: "square.and.pencil")
////                    .foregroundColor(.blue)
////                }
                ForEach(self.data.cache.myRecipes, id:\.self){
                    recipe in
                    NavigationLink(destination:RecipeDetail(id: recipe.id, title: recipe.name).environmentObject(self.data))
                    {
                        
                        Text(recipe.name)
 
                        }
                    }
                }
//            }
        
//
        .navigationTitle("My Recipes")
        .navigationBarItems(trailing: NavigationLink(destination:AddRecipe().environmentObject(self.data)){Image(systemName: "square.and.pencil").font(.headline)})
            .sheet(isPresented: self.$showSheet) {
                AddRecipe().environmentObject(self.data)
            }
        }
        
        .onAppear(){
//            self.navigationTitle.wrappedValue = "My Recipes"
        }
    }
}

struct myRecipe_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MyRecipes(navigationTitle: .constant("My Recipes")).environmentObject(DataModels())
        }
    }
}
