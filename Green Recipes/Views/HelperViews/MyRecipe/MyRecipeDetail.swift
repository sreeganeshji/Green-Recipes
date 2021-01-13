//
//  MyRecipeDetail.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/8/21.
//

import SwiftUI

struct MyRecipeDetail: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var data:DataModels
    @State var recipe:Recipe = .init()
    @State var images:[ImageContainer] = []
    @State var doneLoading:Bool = false
    @State var uploadedByUsername:String = ""
    @State var progress:Double = .init(0)
    @State var spin = false
    @State var showEditSheet = false

    var recipeSummary :RecipeTemplate1
    
    var body: some View {
        VStack{
            if(!doneLoading)
            {
                Text("Loading")
                    .foregroundColor(.blue)
                    .font(.title)
                    .fontWeight(.light)
                    
                    activityIndicator()
                    .onAppear(){
                        GetRecipeByID()
                    }
            }
            else{
//            if editMode?.wrappedValue == EditMode.active{
//                RecipeEditView(recipeNew: self.$recipe, images: self.$images).environmentObject(data)
//            }
//            else{
                RecipeObjectDetail(recipe: self.$recipe, images: self.$images, uploadedByUsername: self.$uploadedByUsername, doneLoading: $doneLoading, title: self.recipe.name).environmentObject(data)
//            }
            }
        }
        
        .sheet(isPresented: $showEditSheet, content: {
            RecipeEditView(recipeNew: self.$recipe, images: self.$images, showSheet:$showEditSheet).environmentObject(data)
        })
//        .navigationBarItems(trailing: EditButton().font(.headline))
        .navigationBarItems(trailing: Button(action:{showEditSheet = true}){Text("Edit").font(.headline)})
    }
    

    func GetRecipeByID(){
        data.networkHandler.searchRecipeWithID(id: recipeSummary.id, completion: UpdateRecipe)
    }
    
    func progresscb(p:Double){
        progress = p
    }
    
    //simultaneous operation
    func getImages2(){
        if recipe.images == nil{
            return
        }
            
            func updateImages(name:String, imageData:Data){
                self.images.append(.init(name: name, image: UIImage(data: imageData)!))
                spin = false
//                let prog = Double(images.count)/Double(recipe.images!.count)
//                updateProgress(p: prog)
                
//                completion()
            }
            
        for image in recipe.images!{
            DispatchQueue.main.async{
            //download images
            let storage = AmplifyStorage()
            
                storage.downloadData(key: image, completion: updateImages, progresscb: progresscb)
        spin = true
        while(spin)
        {
        
        }
            }
        }
    }
        
    func GetImages(){
        if (self.recipe.images != nil && self.recipe.images!.count > 0){
            if self.images.count < self.recipe.images!.count{
                let i = self.images.count
            //download images
                AmplifyStorage().downloadData(key: self.recipe.images![i], completion: UpdateImages, progresscb: progresscb)
            }
        }
    }
        
    func UpdateImages(name:String, image:Data){
        self.images.append(.init(name:name, image:UIImage(data: image)!))
            GetImages()
        }

    func UpdateRecipe(recipe:Recipe){
//        loading = false
        self.recipe = recipe
    //    fetchReviews()
//        GetImages()
//        fillImages()
        getImages2()
    //fetch username
    self.uploadedByUsername = self.data.user.username
        
        doneLoading = true

    }
    
    func fillImages(){
        if recipe.images == nil{
            return
        }
        for imageName in recipe.images!{
            self.images.append(.init(name: imageName, image: .init()))
        }
    }
        
//    func fetchReviews(){
//        //use the recipe id to find the reviews.
//        self.data.networkHandler.fetchReviews(recipe_id: self.recipe.id!, completion: updateReviews)
//    }
        
//        func updateReviews(reviews: [Review], err: Error?){
//            if err != nil{
//                print("Coudln't update reviews")
//                return
//            }
//            self.reviews = reviews
//            updateAverage()
//
        
//        func updateAverage(){
//            let total:Double = reviews.reduce(0.0) { (result:Double, review:Review) -> Double in
//                result + Double(review.rating)
//            }
//            let average = total/Double(reviews.count)
//            self.average = average
//        }

}

//struct MyRecipeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        MyRecipeDetail(recipeSimple: .init(id: 0, name: "Stuff", category: nil)).environmentObject(DataModels())
//    }
//}
