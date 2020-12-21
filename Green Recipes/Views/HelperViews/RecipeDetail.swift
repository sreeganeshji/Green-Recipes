//
//  RecipeDetail.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/20/20.
//

import SwiftUI

class ObservedRecipe:ObservableObject{
    @Published var recipe:Recipe
    init(recipe:Recipe){
        self.recipe = recipe
    }
}


struct RecipeDetail: View {
    var id :Int
    @StateObject var recipe = ObservedRecipe(recipe: Recipe())
    @EnvironmentObject var data:DataModels
    var body: some View {
        NavigationView{
        Form
        {
            //description
            if(self.recipe.recipe.description != nil){
            Section{
                HStack{
                    Spacer()
                    Text("Description").bold()
                Spacer()
            }

                Text(self.recipe.recipe.description!)
                }
            }
            
            
            //Ingredients
            Section{
            HStack {
                Spacer()
                Text("Ingredients").bold()
                Spacer()
            }
                
                
                if(self.recipe.recipe.ingredients.count>0)
                {
                    List{
                        ForEach(Array(zip(self.recipe.recipe.ingredients,(1...self.recipe.recipe.ingredients.count))),id:\.1){
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
                if(self.recipe.recipe.process.count>0)
                {
                    List{
                        ForEach(Array(zip((1...self.recipe.recipe.process.count),self.recipe.recipe.process)),id:\.0){
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
                Text("\(self.recipe.recipe.servings)")
                Spacer()
            }.padding()
            
            //Equipments
            Section{
            HStack {
                Spacer()
                Text("Equipment").bold()
                Spacer()
            }
                if(self.recipe.recipe.equipment != nil && self.recipe.recipe.equipment!.count > 0 )
                {
                    List{
                        ForEach(Array(zip((1...self.recipe.recipe.equipment!.count),self.recipe.recipe.equipment!)),id:\.0){
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

        .navigationBarTitle(Text(self.recipe.recipe.name), displayMode: .inline)
        }
    }


func GetRecipeByID(){
    data.networkHandler.searchRecipeWithID(id: id, completion: UpdateRecipe)
}

func UpdateRecipe(recipe:Recipe){
    
    self.recipe.recipe = recipe
}
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(id:1).environmentObject(DataModels())
    }
}
