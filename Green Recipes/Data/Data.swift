//
//  Data.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/30/20.
//

import Foundation


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
    var addedby:String?
    var nutrition:[String]?
    var category:String?
    var pictures:[String]?

    init() {
        self.name = ""
        self.process = []
        self.servings = 1
        self.pictures = []
        self.ingredients = []
        self.equipment = []
        self.images = []
        self.addeddate = ""
        self.addedby = ""
        self.nutrition = []
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
}

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

struct cache{
    //store common values.
    var timeUpdated:Date
    
    //list of all recipes
    var allRecipes:[RecipeTemplate1]
    
    //explore page
    
    
}

class DataModels:ObservableObject{

    
    var recipies = [Recipe]()
    
//    var networkHandler = NetworkAdapter("http://localhost:5000")
    var networkHandler = NetworkAdapter(nil)
    
    var user = User()
    
    
}
