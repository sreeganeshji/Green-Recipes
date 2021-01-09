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
    @State var images:[ImageContainer] = []
    @EnvironmentObject var data:DataModels
    @State var reviews:[Review] = []
    @State var loading = true
    @State var average:Double = 0
    @State var uploadedByUsername:String = ""
    let title:String
    var body: some View {
        if loading {
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
                if(self.recipe.equipment != nil && self.recipe.equipment!.count > 0 )
            {
            Section{
            HStack {
                Spacer()
                Text("Equipments")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                Spacer()
            }

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

                if (self.recipe.images != nil && self.recipe.images!.count > 0){
                    Section{
                        //images
//                        HStack{
//                            Spacer()
//                        Text("Images")
//                            .font(.title)
//                            .fontWeight(.light)
//                            .foregroundColor(.blue)
//                            Spacer()
//
//                        }
                        
                        ImageCarouselPreview(images:self.$images)
                            .frame(maxHeight:300)
                            .padding(.top)
                            .padding(.bottom)
                        
                        
                    }
                }
                if(self.recipe.category != nil || self.recipe.contributor != nil){
                Section{
                    if (self.recipe.category != nil){
                    HStack{
                    Text("Category:")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                        Spacer()
                        Text(self.recipe.category!)
                    }
                    }
                    if(self.recipe.contributor != nil)
                    {
                        HStack{
                        Text("Contributor:")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.blue)
                            Spacer()
                            Text(self.recipe.contributor!)
                        }
                    }
                }
                }
                
                //Nutrition
                    if(self.recipe.nutrition != nil && self.recipe.nutrition!.count > 0 )
                {
                Section{
                HStack {
                    Spacer()
                    Text("Nutrition")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                    Spacer()
                }

                        List{
                            ForEach(Array(zip((1...self.recipe.nutrition!.count),self.recipe.nutrition!)),id:\.0){
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
                
                if (self.uploadedByUsername != ""){
                    NavigationLink(destination:MoreByUserView(username: self.uploadedByUsername, userid: self.recipe.addedby!).environmentObject(self.data)){
                Section{
                    HStack{
                        Text("Added by:")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.blue)
                        Spacer()
                        Text(self.uploadedByUsername)
                            .lineLimit(1)
                    }
                }
            }
            }
                
                Section{
//                VStack{
//                    ReviewsSummary(user: self.$data.user, recipe: self.$recipe, reviews: self.$reviews).environmentObject(self.data)
//                }
                NavigationLink(destination:
                                ReviewsSummary(user: self.$data.user, recipe: self.$recipe, reviews:self.$reviews, average: self.$average, fetchReviews: fetchReviews).environmentObject(self.data))
                {
                    VStack{
                    Text("Ratings & Reviews")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.blue)
//                    ReviewStarSummary(reviews: self.$reviews)
//                        .padding()
                    }
                }
            }
            }
        }

//        .navigationBarTitle(Text(self.recipe.name), displayMode: .inline)
        .navigationTitle(self.title)
            
        }
    }


func GetRecipeByID(){
    print("ID is \(id)")
    data.networkHandler.searchRecipeWithID(id: id, completion: UpdateRecipe)
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
if (self.recipe.addedby != nil){
self.data.networkHandler.getUserName(userId: self.recipe.addedby!, completion: updateUsername)
}
}
    
func fetchReviews(){
    //use the recipe id to find the reviews.
    self.data.networkHandler.fetchReviews(recipe_id: self.id, completion: updateReviews)
}
    
    func updateReviews(reviews: [Review], err: Error?){
        if err != nil{
            print("Coudln't update reviews")
            return
        }
        self.reviews = reviews
        updateAverage()
        
    }
    
    func updateUsername(username:String, err:Error?){
        if err != nil{
            return
        }
        self.uploadedByUsername = username
    }
    
    func updateAverage(){
        let total:Double = reviews.reduce(0.0) { (result:Double, review:Review) -> Double in
            result + Double(review.rating)
        }
        let average = total/Double(reviews.count)
        self.average = average
    }

}

//struct RecipeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetail(id:1).environmentObject(DataModels())
//    }
//}
