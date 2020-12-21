//
//  RecipeDetail.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/20/20.
//

import SwiftUI


struct RecipeDetail: View {
    var id :Int
    @StateObject var recipe = Recipe()
    @EnvironmentObject var data:DataModels
    var body: some View {
        NavigationView{
        Form
        {
            //description
            if(self.recipe.description != nil){
            Section{
                HStack{
                    Spacer()
                    Text("Description").bold()
                Spacer()
            }

                Text(self.recipe.description!)
                }
            }
            
            
            //Ingredients
            Section{
            HStack {
                Spacer()
                Text("Ingredients").bold()
                Spacer()
            }
                
                
                if(self.recipe.ingredients.count>0)
                {
                    List{
                        ForEach(Array(zip(self.recipe.ingredients,(1...self.recipe.ingredients.count))),id:\.1){
                    item in
                    HStack{
                        Text("\(item.1).").bold()
                        Spacer()
                        Text(item.0)
                        Spacer()
                    }.padding()
                }

                    }
            }

            }
            
            //Process
            Section{
            HStack {
                Spacer()
                Text("Process").bold()
                Spacer()
            }
                if(self.recipe.process.count>0)
                {
                    List{
                        ForEach(Array(zip((1...self.recipe.process.count),self.recipe.process)),id:\.0){
                    item in
                            HStack{
                                Text("\(item.0).").bold()
                                Spacer()
                                Text(item.1)
                                Spacer()
                            }.padding()
                        }
        
                    }
            }
        
            }
           
            HStack{
                Text("Servings:").bold()
                Spacer()
                Text("\(self.recipe.servings)")
                Spacer()
            }.padding()
            
            //Equipments
            Section{
            HStack {
                Spacer()
                Text("Equipment").bold()
                Spacer()
            }
                if(self.recipe.equipment != nil && self.recipe.equipment!.count > 0 )
                {
                    List{
                        ForEach(Array(zip((1...self.recipe.equipment!.count),self.recipe.equipment!)),id:\.0){
                    item in
                            HStack{
                                Text("\(item.0).").bold()
                                Spacer()
                                Text(item.1)
                                Spacer()
                            }.padding()
                        }
        
                    }
            }
        
            }


        }
            .onAppear(){
                GetRecipeByID()
            }

        .navigationBarTitle(Text(self.recipe.name), displayMode: .inline)
        }
    }


func GetRecipeByID(){
    data.networkHandler.searchRecipeWithID(id: id, completion: UpdateRecipe)
}

func UpdateRecipe(recipe:Recipe){
    self.recipe.copy(from: recipe)
}
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(id:1).environmentObject(DataModels())
    }
}
