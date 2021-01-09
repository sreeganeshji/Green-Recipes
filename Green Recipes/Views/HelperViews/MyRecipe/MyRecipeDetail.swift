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
    @State var recipe:Recipe
    @State var images:[ImageContainer] = []
    @State var loading:Bool = true
    @State var uploadedByUsername:String = ""

    var recipeSummary :RecipeTemplate1
    
    var body: some View {
        VStack{
            if(loading)
            {
                Text("Loading")
                    .foregroundColor(.blue)
                    .font(.title)
                    .fontWeight(.light)
                    .onAppear(){
                        GetRecipeByID()
                    }
            }
            else{
            if editMode?.wrappedValue == EditMode.active{
                RecipeEditView(recipeNew: self.recipe, images: self.images).environmentObject(data)
            }
            else{
                RecipeObjectDetail(recipe: self.$recipe, images: self.$images, uploadedByUsername: self.$uploadedByUsername, title: self.recipe.name).environmentObject(data)
            }
            }
        }
        .navigationBarItems(trailing: EditButton().font(.headline))
    }
    

    func GetRecipeByID(){
        data.networkHandler.searchRecipeWithID(id: recipeSummary.id, completion: UpdateRecipe)
    }
        
    func GetImages(){
        if (self.recipe.images != nil && self.recipe.images!.count > 0){
            if self.images.count < self.recipe.images!.count{
                let i = self.images.count
            //download images
            self.data.photoStore.downloadData(key: self.recipe.images![i], completion: UpdateImages)
            }
        }
    }
        
    func UpdateImages(name:String, image:Data){
        self.images.append(.init(name:name, image:UIImage(data: image)!))
            GetImages()
        }

    func UpdateRecipe(recipe:Recipe){
        loading = false
        self.recipe = recipe
    //    fetchReviews()
        GetImages()
        
    //fetch username
    self.uploadedByUsername = self.data.user.username

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
