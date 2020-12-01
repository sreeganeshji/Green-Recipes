//
//  AddRecipe.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/30/20.
//

import SwiftUI

struct AddRecipe: View {
    @EnvironmentObject var data:DataModels
    @State var recipeNew = Recipe()
    @State var newIngredient:String = ""
    @State var newProcess:String = ""
    var body: some View {
        NavigationView{


        Form{
            Section{
            HStack{
                Text("Name:").bold()
                TextField("Add name", text: $recipeNew.name)
            }
            }
            Section{
                HStack{
                    Spacer()
                    Text("Description").bold()
                Spacer()
            }

                TextEditor(text: $recipeNew.description)
            }
            Section{
            HStack {
                Spacer()
                Text("Ingredients").bold()
                Spacer()
            }
                if(recipeNew.ingredients.count>0)
                {
                    List{
                        ForEach(Array(zip(recipeNew.ingredients,(1...recipeNew.ingredients.count))),id:\.1){
                    item in
                    HStack{
                        Text("\(item.1).").bold()
                        Spacer()
                        Text(item.0)
                        Spacer()
                    }.padding()
                }
                .onDelete(perform: { ind in
                    self.recipeNew.ingredients.remove(atOffsets: ind)
                })
                    .onMove { (IndSet, ind) in
                        self.recipeNew.ingredients.move(fromOffsets: IndSet, toOffset: ind)
            }
                    }
            }
                HStack{
                    TextField("Add ingredient", text: $newIngredient)
                    Button(action:addIngredient){
                        Text("Add")
                    }
                }
            }
            
            Section{
            HStack {
                Spacer()
                Text("Process").bold()
                Spacer()
            }
                if(recipeNew.process.count>0)
                {
                    List{
                        ForEach(Array(zip((1...recipeNew.process.count),recipeNew.process)),id:\.0){
                    item in
                            HStack{
                                Text("\(item.0).").bold()
                                Spacer()
                                Text(item.1)
                                Spacer()
                            }.padding()
                }
                .onDelete(perform: { ind in
                    self.recipeNew.process.remove(atOffsets: ind)
                })
                    .onMove { (IndSet, ind) in
                        self.recipeNew.process.move(fromOffsets: IndSet, toOffset: ind)
            }
                    }
            }
                HStack{
                    TextField("Add step", text: $newProcess)
                    Button(action:addProcess){
                        Text("Add")
                    }
                }
            }
           
            Stepper(value: $recipeNew.servings, in: 0...100) {
                HStack{
                    Text("Servings:").bold()
                    Spacer()
                    Text("\(self.recipeNew.servings)")
                    Spacer()
                }
            }

            Section{
                Button(action:submitRecipe)
                {
                    HStack{
                        Spacer()
                    Text("Submit")
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle(Text("Add Recipe"))
        .navigationBarItems(trailing: Button(action:{}){
            Text("Done")
        })
        .navigationBarItems(leading: EditButton())
      
        }
        .onDisappear(){
      
        }
    }
    
    func addIngredient(){
        if self.newIngredient != ""{
        self.recipeNew.ingredients.append(self.newIngredient)
        }
        self.newIngredient = ""
    }
    func addProcess(){
        if self.newProcess != ""{
            self.recipeNew.process.append(self.newProcess)
        }
        self.newProcess = ""
    }
    func submitRecipe(){
        //validate the fields
        self.data.networkHandler.addRecipe(recipe: self.recipeNew)
    }
}

struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipe().environmentObject(DataModels())
    }
}
