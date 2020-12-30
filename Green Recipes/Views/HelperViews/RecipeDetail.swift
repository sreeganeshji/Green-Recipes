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
//    @StateObject var recipe = ObservedRecipe(recipe: Recipe())
    @State var recipe = Recipe()
    @EnvironmentObject var data:DataModels
    var body: some View {
        if self.recipe.name == ""{
            Text("Loading...")
                .foregroundColor(.blue)
                .font(.title)
                .fontWeight(.light)
                .onAppear(){
                    GetRecipeByID()
                }
        }
        else{

        VStack
        {
            Form{
            //description
            if(self.recipe.description != nil){
            Section{
                HStack{
                    Spacer()
                    Text("Description").bold().italic()
                Spacer()
            }

                Text(self.recipe.description!)
                }
            }
            
            
            //Ingredients
            Section{
            HStack {
                Spacer()
                Text("Ingredients").foregroundColor(.blue)
                    .fontWeight(.light)
                    .font(.title)
                
                Spacer()
            }
                
                
                if(self.recipe.ingredients.count>0)
                {
                    List{
                        ForEach(Array(zip(self.recipe.ingredients,(1...self.recipe.ingredients.count))),id:\.1){
                    item in
                    HStack{
                        Text("\(item.1).").font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.blue)
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
                Text("Process")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                Spacer()
            }
                if(self.recipe.process.count>0)
                {
                    List{
                        ForEach(Array(zip((1...self.recipe.process.count),self.recipe.process)),id:\.0){
                    item in
                            HStack{
                                Text("\(item.0).")
                                    .font(.title)
                                    .fontWeight(.light)
                                    .foregroundColor(.blue)
                                Spacer()
                                Text(item.1)
                                Spacer()
                            }.padding()
                        }
        
                    }
            }
        
            }
           
            HStack{
                Text("Servings:").font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                Spacer()
                Text("\(self.recipe.servings)")
                Spacer()
            }.padding()
            
            //Equipments
            Section{
            HStack {
                Spacer()
                Text("Equipment")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                Spacer()
            }
                if(self.recipe.equipment != nil && self.recipe.equipment!.count > 0 )
                {
                    List{
                        ForEach(Array(zip((1...self.recipe.equipment!.count),self.recipe.equipment!)),id:\.0){
                    item in
                            HStack{
                                Text("\(item.0).")
                                    .font(.title)
                                    .fontWeight(.light)
                                    .foregroundColor(.blue)
                                Spacer()
                                Text(item.1)
                                Spacer()
                            }.padding()
                        }
        
                    }
            }
        
            }


        }
        }


//        .navigationBarTitle(Text(self.recipe.name), displayMode: .inline)
        .navigationTitle(self.recipe.name)
            
        }
    }


func GetRecipeByID(){
    print("ID is \(id)")
    data.networkHandler.searchRecipeWithID(id: id, completion: UpdateRecipe)
}

func UpdateRecipe(recipe:Recipe){
    
    self.recipe = recipe
}
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(id:1).environmentObject(DataModels())
    }
}
