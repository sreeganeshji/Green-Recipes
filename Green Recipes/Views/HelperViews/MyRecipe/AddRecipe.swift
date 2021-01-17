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
    @State var description:String = ""
    @State var newEquipment:String = ""
    @State var newNutrition:String = ""
    @State var origin:String = ""
    @State var images:[ImageContainer] = []
    @State var showSheetAddImages:Bool = false
    @State var showAlert = false
    @State var alertMessage = ""
    @State var alertTitle = "Cannot Submit"
    @State var recipeNewCategory = "Others"
    @State var recipeUserCategory = ""
    @State var recipeNewContributor = ""
    
    var body: some View {

        Form{
            Section{
            HStack{
                Text("Name:")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                TextField("Add name", text: $recipeNew.name)
            }
            }
            Section{
                HStack{
                    Spacer()
                    Text("Description")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                    Text("(Optional)").foregroundColor(.secondary)
                Spacer()
            }

                TextEditor(text: self.$description)
            }
            Section{
            HStack {
                Spacer()
                Text("Ingredients")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                
                Spacer()
            }
                if(recipeNew.ingredients.count>0)
                {
                    List{
                        ForEach(Array(zip(recipeNew.ingredients,(1...recipeNew.ingredients.count))),id:\.1){
                    item in
                    HStack{
                        Text("\(item.1).")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.blue)
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
                        Image(systemName:"plus.circle.fill")
                    }
                }
            }
            
            Section{
            HStack {
                Spacer()
                Text("Process")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                Spacer()
            }
                if(recipeNew.process.count>0)
                {
                    List{
                        ForEach(Array(zip((1...recipeNew.process.count),recipeNew.process)),id:\.0){
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
                        Image(systemName:"plus.circle.fill")
                    }
                }
            }
            
            Section{
            HStack {
                Spacer()
                Text("Equipments")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                Text("(Optional)").foregroundColor(.secondary)
                Spacer()
            }
                //recipenew.equipment is initialized to []
                if(recipeNew.equipment != nil && recipeNew.equipment!.count>0)
                {
                    List{
                        ForEach(Array(zip((1...recipeNew.equipment!.count),recipeNew.equipment!)),id:\.0){
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
                .onDelete(perform: { ind in
                    self.recipeNew.equipment!.remove(atOffsets: ind)
                })
                    .onMove { (IndSet, ind) in
                        self.recipeNew.equipment!.move(fromOffsets: IndSet, toOffset: ind)
            }
                    }
            }
                HStack{
                    TextField("Add equipment", text: $newEquipment)
                    Button(action:addEquipment){
                        Image(systemName:"plus.circle.fill")
                    }
                }
            }
           
            Stepper(value: $recipeNew.servings, in: 0...100) {
                HStack{
                    Text("Servings:")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                    Spacer()
                    Text("\(self.recipeNew.servings)")
                    Spacer()
                }
            }
            
            Section{
                //images
                HStack{
                    Spacer()
                Text("Images")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                Text("(Optional)").foregroundColor(.secondary)
                    Spacer()
                    Button(action:{self.showSheetAddImages = true}){
                        Image(systemName:"plus.circle.fill")
                    }
                }
                
                ImageCarousel(images:self.$images)
                    .frame(maxHeight:300)
                
                
            }
            
            Section{

                HStack{
                    Spacer()
                    Text("Category")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                    Text("(Optional)").foregroundColor(.secondary)
                    Spacer()
   
            }
                
                Picker(selection: self.$recipeNewCategory, label:Text("Selected Category")) {
                    ForEach(categories,id:\.self){
                        category in
                        Text(category).tag(category)
                    }
                    
                }
        
                
                if(self.recipeNewCategory == "Others")
                {
                    TextField("Enter category", text: self.$recipeUserCategory)
                }

                HStack{
                    Spacer()
                    Text("Contributor")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                    Text("(Optional)").foregroundColor(.secondary)
                    Spacer()
                }
                    TextField("Add Contributor", text: self.$recipeNewContributor)
                
                HStack{
                    Spacer()
                    Text("Origin")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                    Text("(Optional)").foregroundColor(.secondary)
                    Spacer()
                }
                    TextField("Add Origin", text: self.$origin)
            }
            
            Section
            {
                
//            }
            
//            Section{
            HStack {
                Spacer()
                Text("Nutrition")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                Text("(Optional)").foregroundColor(.secondary)
                Spacer()
            }
//                recipenew.equipment is initialized to []
                if(recipeNew.nutrition != nil && recipeNew.nutrition!.count>0)
                {
                    List{
                        ForEach(Array(zip((1...recipeNew.nutrition!.count),recipeNew.nutrition!)),id:\.0){
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
                .onDelete(perform: { ind in
                    self.recipeNew.nutrition!.remove(atOffsets: ind)
                })
                    .onMove { (IndSet, ind) in
                        self.recipeNew.nutrition!.move(fromOffsets: IndSet, toOffset: ind)
            }
                    }
            }
                HStack{
                    TextField("Add equipment", text: $newNutrition)
                    Button(action:addNutrition){
                        Image(systemName:"plus.circle.fill")
                    }
                }
            }
            
//            HStack{
//                Text("Origin:").bold()
//                TextField("", text: self.$origin)
//            }

            Section{
                Button(action:submitRecipe)
                {
                    HStack{
                        Spacer()
                    Text("Submit")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                        Spacer()
                    }
                }
            }

        }
        .alert(isPresented: self.$showAlert, content: {
            Alert(title: Text(self.alertTitle), message: Text(self.alertMessage))
        })

        .sheet(isPresented: self.$showSheetAddImages, content: {
            PhotoPicker(showSheet: self.$showSheetAddImages, images: self.$images)
        })

        .navigationTitle(Text("Add Recipe"))
        .navigationBarItems(trailing: EditButton())
              
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
    func addEquipment(){
        if self.newEquipment != ""{
            self.recipeNew.equipment!.append(self.newEquipment)
        }
        self.newEquipment = ""
    }
    func addNutrition(){
        if self.newNutrition != ""{
            self.recipeNew.nutrition!.append(self.newNutrition)
        }
        self.newNutrition = ""
    }
    func submitRecipe(){
        
        //ensure ingredients and process are entered
        if (self.recipeNew.ingredients.count == 0 ) || (self.recipeNew.process.count == 0) || (self.recipeNew.name == ""){
            //show alert
            self.alertTitle = "Cannot Submit"
            self.alertMessage = "Please add Name, Ingredients and Process."
            self.showAlert = true
            return
        }
        //blur and freeze the screen
        
        //add the rest of the fields.
        self.recipeNew.origin = self.origin
        self.recipeNew.addedby = self.data.user.userId
        self.recipeNew.description = self.description
        self.recipeNew.contributor = self.recipeNewContributor
        self.recipeNew.category = self.recipeNewCategory
        
        //upload images
        for image in self.images{
            //generate a key
//            let key = self.getImageName()
            
            //upload to aws S3
            AmplifyStorage().uploadData(key: image.name, data: image.image.pngData()!)
            
            //add to the new recipe
            recipeNew.images?.append(image.name)
            
        }
        
        
        //validate the fields
        self.data.networkHandler.addRecipe(recipe: self.recipeNew)
        
        //add to myrecipes
//        self.data.fetchMyRecipes(userId: self.data.user.userId)
        //complete here
        
        //clear all values
        recipeNew = Recipe()
        newIngredient = ""
        newProcess = ""
        description = ""
        newEquipment = ""
        newNutrition = ""
        recipeNewContributor = ""
        recipeNewCategory = ""
        recipeUserCategory = ""
        origin = ""
        images = []
        self.alertTitle = "Success"
        self.alertMessage = "Recipe Submitted"
        self.showAlert = true
    }
    

}

struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipe().environmentObject(DataModels())
    }
}
