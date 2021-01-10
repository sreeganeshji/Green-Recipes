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
    @State var myRecipes:[RecipeTemplate1] = []
    
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
                ForEach(myRecipes, id:\.self){
                    recipe in
                    NavigationLink(destination:MyRecipeDetail(recipeSummary:recipe).environmentObject(self.data))
                    {
                        
                        Text(recipe.name)
 
                        }
                    }
                }
//            }
        
//
        .navigationTitle("My Recipes")
        .navigationBarItems(trailing: NavigationLink(destination:AddRecipe().environmentObject(self.data)
            .onDisappear(){
                fetchMyRecipes()
            }
        ){Image(systemName: "square.and.pencil").font(.headline)})
            .sheet(isPresented: self.$showSheet) {
                AddRecipe().environmentObject(self.data)
            }
        }
        
        .onAppear(){
//            self.navigationTitle.wrappedValue = "My Recipes"
                fetchMyRecipes()
        }
    }
    
    func fetchMyRecipes(){
        self.data.networkHandler.fetchMyRecipes(userId: self.data.user.userId, completion: updateMyRecipes)
    }
    
    func updateMyRecipes(recipes:[RecipeTemplate1], err:Error?){
        if err != nil{
            print("Error fetching my recipes \(err!)")
            return
        }
        self.myRecipes = recipes
    }
}

struct myRecipe_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MyRecipes(navigationTitle: .constant("My Recipes")).environmentObject(DataModels())
        }
    }
}
