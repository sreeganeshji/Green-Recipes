//
//  RecipeEditView.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/6/21.
//

import SwiftUI

struct RecipeEditView: View {
    @EnvironmentObject var data:DataModels
    @Binding var recipeNew :Recipe
    @State var newIngredient:String = ""
    @State var newProcess:String = ""
    @State var description:String = ""
    @State var newEquipment:String = ""
    @State var newNutrition:String = ""
    @State var origin:String = ""
    @Binding var images:[ImageContainer]
    @State var showSheetAddImages:Bool = false
    @State var showAlert = false
    @State var alertMessage = ""
    @State var recipeNewCategory = "Others"
    @State var recipeUserCategory = ""
    @State var recipeNewContributor = ""
    @Environment(\.editMode) var editMode
    
    
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
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
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
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
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
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
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
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
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
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
//            HStack{
//                Text("Origin:").bold()
//                TextField("", text: self.$origin)
//            }

           
//            Section{
//                Button(action:submitRecipe)
//                {
//
//                    HStack{
//                        Spacer()
//                    Text("Update")
//                        .font(.title)
//                        .fontWeight(.light)
//                        .foregroundColor(.blue)
//                        Spacer()
//                    }
//                }
//                .buttonStyle(PlainButtonStyle())
//
//            }
            .alert(isPresented: self.$showAlert, content: {
                Alert(title: Text("Cannot Submit"), message: Text(self.alertMessage))
            })
        }
 
        .sheet(isPresented: self.$showSheetAddImages, content: {
            PhotoPicker(showSheet: self.$showSheetAddImages, images: self.$images)
        })

//        .navigationTitle(Text("Edit Recipe"))
              
        .onAppear(){
            recipeNew.nutrition = recipeNew.nutrition ?? []
            recipeNew.equipment = recipeNew.equipment ?? []

            description = recipeNew.description ?? ""
            origin = recipeNew.origin ?? ""
            recipeNewCategory = recipeNew.category ?? ""
            recipeNewContributor = recipeNew.contributor ?? ""
        }
        .onDisappear(){
      submitRecipe()
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
            self.alertMessage = "Please add Name, Ingredients and Process."
            self.showAlert = true
            return
        }
        //blur and freeze the screen
        
        //add the rest of the fields.
        self.recipeNew.origin = self.origin
        self.recipeNew.addedby = self.data.user.userId
        
        //current set
        let oldImages = self.recipeNew.images ?? []
        //upload images
        for image in images{
            
            //continue if already exists
            if oldImages.contains(image.name){
                continue
            }
            
            //generate a key
//            let key = self.getImageName()
            
            //upload to aws S3
            self.data.photoStore.uploadData(key: image.name, data: image.image.pngData()!)
            
            //add to the new recipe
            recipeNew.images?.append(image.name)
        }
            
            //delete the recipes which are not in the origianl set.
        
        let newImageNames = images.map({$0.name})
        
            for imageName in oldImages{
                if !newImageNames.contains(imageName){
                    //delete that image
                    self.data.photoStore.deleteData(key: imageName)
                    recipeNew.images?.removeAll(where: { (s:String) -> Bool in
                        return (s == imageName)
                    })
                }
            }
            
        
        
        

        self.data.networkHandler.updateRecipe(recipe: self.recipeNew)
        
        //add to myrecipes
//        self.data.fetchMyRecipes(userId: self.data.user.userId)
        //complete here

    }
    
    //GenerateRandomString
//    func getImageName()->String{
//        let base = self.data.user.appleId
//
//        //generate random string
//        let length = 8
//        let letters = "abcdefghijklmnopqrstuvwzyxABCDEFGHIJKLMNOPQRSTUVWXYZ"
//        let randomString = String((0...length).map { _ in
//                                    letters.randomElement()!})
//        let name = base + randomString
//        return name
//    }
}


//struct RecipeEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeEditView(recipeNew: .init(), images: []).environmentObject(DataModels())
//    }
//}
