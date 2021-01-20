//
//  Data.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/30/20.
//

import Foundation
import UIKit


struct Recipe: Hashable, Equatable, Codable{

    /*
     ID          int       `json:"id"`
     Name        string    `json:"name"`
     Ingredients []string  `json:"ingredients"`
     Process     []string  `json:"process"`
     Contributor string    `json:"contributor"`
     Origin      string    `json:"origin"`
     Servings    float32   `json:"servings"`
     Equipment   []string  `json:"equipment"`
     Images      [] string `json:"images"`
     AddedDate   string    `json:"added_date"`
     Addedby     string    `json:"addedby"`
     Nutrition []string `json:"nutrition"`
     Category string `json:"category"`
     */
    var id:Int?
    var name:String
    var description:String?
    var ingredients:[String]
    var process:[String]
    var contributor:String?
    var origin:String?
    var servings:Int
    var equipment:[String]?
    var images:[String]?
    var addeddate:String?
    var addedby:Int?
    var nutrition:[String]?
    var category:String?
    var rating:Double?
    var ratingCount:Int?
    var estimatedTime:String?
    
    enum CodingKeys:String, CodingKey{
        case id = "id"
        case name = "name"
        case description = "description"
        case ingredients = "ingredients"
        case process = "process"
        case contributor = "contributor"
        case origin = "origin"
        case servings = "servings"
        case equipment = "equipment"
        case images = "images"
        case addeddate = "added_date"
        case addedby = "addedby"
        case nutrition = "nutrition"
        case category = "category"
        case rating = "rating"
        case ratingCount = "rating_count"
        case estimatedTime = "estimated_time"
    }

    init() {
        self.name = ""
        self.process = []
        self.servings = 1
        self.ingredients = []
    }
    init(name:String, description:String){
        self.init()
        self.name = name
        self.description = description
    }
}

struct RecipeTemplate1:Codable, Hashable{
    var id:Int
    var name:String
    var category:String?
    var rating:Float64?
    var ratingCount:Int?
    
    enum CodingKeys:String, CodingKey{
        case id = "id"
        case name = "name"
        case rating = "rating"
        case ratingCount = "rating_count"
        
    }
}

//categories 
let categories = ["Others","Desserts", "Snacks", "Lunch/Dinner", "Drinks", "Soups", "Salads"]

struct Comment:Hashable, Codable{
    var creator:User
    var body:String
    var uuid:Int
}

struct User:Hashable, Equatable, Codable{
    
    var username:String
    var firstName:String
    var lastName:String
    var profilePic:String?
    var email:String
    var userId:Int
    var appleId:String
    
    init(){
        self.username = ""
        self.firstName = ""
        self.lastName = ""
        self.userId = 0
        self.appleId = ""
        self.email = ""
    }
    
    mutating func copyFrom(user:User){
        username = user.username
        firstName = user.firstName
        lastName = user.lastName
        userId = user.userId
        appleId = user.appleId
        email = user.email
        profilePic = user.profilePic
    }
    
    enum CodingKeys:String, CodingKey{
        case firstName = "firstname"
        case lastName = "lastname"
        case userId = "userid"
        case appleId = "appleid"
        case username = "username"
        case email = "email"
        case profilePic = "profilepic"
    }
}

struct ImageContainer:Hashable{
    var name:String
    var image:UIImage
}

struct Ratings:Hashable, Codable{
    var rateDict:[User:Double]
    var avgRate:Double{
        var avgRate:Double = 0
        for entry in rateDict{
            avgRate += entry.value
        }
        let N = Double(rateDict.count)
        return avgRate/N
    }
    init(){
        self.rateDict = .init()
    }
}

struct Review:Codable, Hashable{
    var Id:Int?
    var rating:Int
    var body:String?
    var recipeId:Int
    var userId:Int
    var created:String?
    var title:String
    
    enum CodingKeys:String, CodingKey{
        case recipeId = "recipefk"
        case rating = "stars"
        case body = "body"
        case userId = "personfk"
        case created = "created"
        case Id = "id"
        case title = "title"
    }
    
    init(){
        self.rating = 0
        self.recipeId = 0
        self.userId = 0
        self.title = ""
    }
}

struct Report:Codable, Hashable{
    var Id:Int?
    var body:String?
    var recipeId:Int
    var userId:Int
    var created:String?
    var title:String
    
    enum CodingKeys:String, CodingKey{
        case recipeId = "recipefk"
        case body = "body"
        case userId = "personfk"
        case created = "created"
        case Id = "id"
        case title = "title"
    }
    
    init(){
        self.recipeId = 0
        self.userId = 0
        self.title = ""
    }
}

struct Cache{
    //store common values.
    var timeUpdated:Date
    
    //list of all recipes
    var allRecipes:[RecipeTemplate1]
    
    //explore page
    
    
    //favorites
    var favRecipes:Set<RecipeTemplate1>
    
    //my recipes
    var myRecipes:[RecipeTemplate1]
    
    init(){
        timeUpdated = .init()
        allRecipes = []
        favRecipes = .init()
        myRecipes = .init()
    }
}

class DataModels:ObservableObject{

    
    var recipies = [Recipe]()
    
    var networkHandler = NetworkAdapter("http://localhost:5000")
//    var networkHandler = NetworkAdapter(nil)
    
    var user = User()
    
    @Published var cache = Cache()
    
    
    func fetchFavorites(){
        
        func updateFavoritesCache(recipes:[RecipeTemplate1]?, error:Error?){
            if error != nil{
                //handle error
                return
            }
            self.cache.favRecipes = Set(recipes!)
        }
        
        self.networkHandler.getUserFavorites(userId: self.user.userId, completion: updateFavoritesCache)
    }
    
    func fetchMyRecipes(userId:Int){
        func updateMyRecipesCache(myRecipes:[RecipeTemplate1], err:Error?){
            if err != nil{
                print("Couldn't update my recipe")
                return
            }
            self.cache.myRecipes = myRecipes
        }
        
        self.networkHandler.fetchMyRecipes(userId: userId, completion: updateMyRecipesCache)
    }
    
    func createFavorites(userId:Int, recipe:RecipeTemplate1){
        self.networkHandler.addFavorite(userId: userId, recipeId: recipe.id)
        self.cache.favRecipes.insert(recipe)
    }
    
    func removeFavorites(userId:Int, recipe:RecipeTemplate1){
        self.networkHandler.removeFavorite(userId: userId, recipeId: recipe.id)
        self.cache.favRecipes.remove(recipe)
    }
    
    func updateCache(){
        fetchFavorites()
        fetchMyRecipes(userId: self.user.userId)
        cache.timeUpdated = .init()
    }
}
