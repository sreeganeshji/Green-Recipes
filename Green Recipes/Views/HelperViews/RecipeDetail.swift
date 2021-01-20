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
    let queue = DispatchQueue.init(label: "ImageFetch", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
    @State var showReportSheet = false
    @State var recipe = Recipe()
    @State var images:[ImageContainer] = []
    @EnvironmentObject var data:DataModels
    @State var reviews:[Review] = []
    @State var loadingDone = false
    @State var uploadedByUsername:String = ""
    @State var report:Report = .init()
    @State var imageLoaded = true
    @State var spin = false
    @State var progress :Double = .init(0.0)
    @State var showProgress = false
    
    let title:String
    var body: some View {
        if !loadingDone {
            VStack{
            Text("Loading...")
                .foregroundColor(.blue)
                .font(.title)
                .fontWeight(.light)
                
                activityIndicator()
                    .onAppear(){
                        GetRecipeByID()
                    }
                if (showProgress){
                ProgressView(value: progress)
                    .padding()
                }

               
            }
        }
        else{
        ZStack{
            Form{
            
            if (self.images.count > 0){

//                ZStack{
                ImageCarousalFetchView(images:self.$images, imagesLoaded: $imageLoaded).environmentObject(self.data)
                        .frame(maxHeight:300)
                        .clipShape(RoundedRectangle(cornerRadius:12))
                    .ignoresSafeArea()
                        .padding(.top)
                        .padding(.bottom)
                        
//                    if(!imageLoaded){
//                        Text("Loading Images...")
//                            .font(.title)
//                            .foregroundColor(.blue)
//                            .fontWeight(.light)
//                            .opacity(0.8)
//                            .frame(height:300)
//                    }
//                }

            }

            //description
                if(self.recipe.description != nil && recipe.description != ""){
            Section{
                HStack{
                    Spacer()
                    Text("Description")
                        .font(.title)
                        .foregroundColor(.blue)
                        .fontWeight(.light)
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

//                if (self.recipe.images != nil && self.recipe.images!.count > 0){
//                    Section{
//                        //images
////                        HStack{
////                            Spacer()
////                        Text("Images")
////                            .font(.title)
////                            .fontWeight(.light)
////                            .foregroundColor(.blue)
////                            Spacer()
////
////                        }
//
//                        ImageCarousalFetchView(images:self.$images).environmentObject(self.data)
//                            .frame(maxHeight:300)
//                            .padding(.top)
//                            .padding(.bottom)
//
//
//                    }
//                }
                if(self.recipe.category != nil || self.recipe.contributor != nil || self.recipe.origin != nil || self.recipe.estimatedTime != nil){
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
                    if(self.recipe.origin != nil)
                    {
                        HStack{
                        Text("Origin:")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.blue)
                            Spacer()
                            Text(self.recipe.origin!)
                        }
                    }
                    if(self.recipe.estimatedTime != nil)
                    {
                        HStack{
                        Text("Estimated Time:")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.blue)
                            Spacer()
                            Text(self.recipe.estimatedTime!)
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
                                ReviewsSummary(user: self.$data.user, recipe: self.$recipe, reviews:self.$reviews, fetchReviews: fetchReviews).environmentObject(self.data))
                {
                    VStack{
                        HStack{

                            StarView(stars: (recipe.rating != nil) ? .constant(recipe.rating!) : .constant(0))
                                    .foregroundColor(.yellow)
                            Spacer()
                            Text((recipe.ratingCount != nil) ? "\(recipe.ratingCount!) ratings" : "0 ratings").foregroundColor(.secondary)
                        }
                        .padding()
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
            
//            if !loadingDone {
//                VStack{
//                Text("Loading...")
//                    .foregroundColor(.blue)
//                    .font(.title)
//                    .fontWeight(.light)
//                    .onAppear(){
//                        GetRecipeByID()
//                    }
////                    ProgressView(value: progress)
//                    ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
//                }
//                .background(blur(radius: 3.0))
//            }
        }
    
            
            .sheet(isPresented: $showReportSheet, content: {
                AddReport(showSheet: $showReportSheet, report: $report).environmentObject(self.data)
            })
            .navigationBarItems(trailing: Button(action:{showReportSheet = true}){Image(systemName:"flag").foregroundColor(.red)})
//        .navigationBarTitle(Text(self.recipe.name), displayMode: .inline)
            .navigationTitle(Text(self.recipe.name))
//        .navigationTitle(self.title)
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
            AmplifyStorage().downloadData(key: self.recipe.images![i], completion: UpdateImages, progresscb: progresscb)
        }
    }
}
    
    func UpdateImages(name:String, image:Data?){
        if image != nil{
        self.images.append(.init(name:name, image:UIImage(data: image!)!))
        }
        GetImages()
    }
    
    func progresscb(p:Double){
    }
    
    func updateProgress(p:Double){
        progress = p
    }
    
    //simultaneous operation
    func getImages2(){
        if recipe.images == nil{
            return
        }
            
            func updateImages(name:String, imageData:Data?){
                if imageData != nil{
                    self.images.append(.init(name: name, image: UIImage(data: imageData!)!))
                }
                spin = false
                let prog = Double(images.count)/Double(recipe.images!.count)
                updateProgress(p: prog)
                
//                completion()
            }
        showProgress = true
            
        for image in recipe.images!{
            DispatchQueue.main.sync{
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
    
    func fillImages(){
        if recipe.images == nil{
            return
        }
        for imageName in recipe.images!{
            self.images.append(.init(name: imageName, image: .init()))
        }
    }

func UpdateRecipe(recipe:Recipe){
    self.recipe = recipe
    
//    fetchReviews()
//    GetImages()
    getImages2()
//    fillImages()
    fillReport()
    loadingDone = true

//fetch username
if (self.recipe.addedby != nil){
self.data.networkHandler.getUserName(userId: self.recipe.addedby!, completion: updateUsername)
}
    
}
    
    func fillReport(){
        report.userId = data.user.userId
        report.recipeId = recipe.id!
    }
    
    func fetchReviews(_ submitAvg:Bool){
    //use the recipe id to find the reviews.
    if submitAvg{
        self.data.networkHandler.fetchReviews(recipe_id: self.id, completion: updateReviews, callback: updateAverage)
    }
    else{
        self.data.networkHandler.fetchReviews(recipe_id: self.id, completion: updateReviews, callback: {})
    }
}
    
    func updateReviews(reviews: [Review], err: Error?, callback: @escaping ()->()){
        if err != nil{
            print("Coudln't update reviews")
            return
        }
        self.reviews = reviews
        callback()
    }
    
    func updateUsername(username:String, err:Error?){
        if err != nil{
            return
        }
        self.uploadedByUsername = username

    }
    
    func updateAverage(){
        if reviews.count == 0{
            data.networkHandler.updateRecipeRating(recipeID: recipe.id!, rating: 0, ratingCount: 0, completion: GetRecipeByID)
            return
        }
        let total:Double = reviews.reduce(0.0) { (result:Double, review:Review) -> Double in
            result + Double(review.rating)
        }
        let average = total/Double(reviews.count)
        data.networkHandler.updateRecipeRating(recipeID: recipe.id!, rating: average, ratingCount: reviews.count, completion: GetRecipeByID)
    }

}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(id:1, title: "Detail stuff").environmentObject(DataModels())
    }
}
