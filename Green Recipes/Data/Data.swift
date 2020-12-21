//
//  Data.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/30/20.
//

import Foundation


class Recipe: Hashable, Equatable, Codable, ObservableObject{
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
    

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
    var id:Int
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
    var hashValue: Int{return self.id}

    init() {
        self.id = 0
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
    convenience init(name:String, description:String){
        self.init()
        self.name = name
        self.description = description
    }
    convenience init(_ recipe:Recipe) {
        self.init()
        id = recipe.id
        name = recipe.name
        ingredients = recipe.ingredients
        process = recipe.process
        equipment = recipe.equipment
        category = recipe.category
        servings = recipe.servings
        description = recipe.description
        addedby = recipe.addedby
        addeddate = recipe.addeddate
        nutrition = recipe.nutrition
        images = recipe.images
    }
    func copy(from recipe2:Recipe){
        id = recipe2.id
        name = recipe2.name
        ingredients = recipe2.ingredients
        process = recipe2.process
        equipment = recipe2.equipment
        category = recipe2.category
        servings = recipe2.servings
        description = recipe2.description
        addedby = recipe2.addedby
        addeddate = recipe2.addeddate
        nutrition = recipe2.nutrition
        images = recipe2.images
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

    var username:String?
    var firstName:String?
    var lastName:String?
    var profilePic:String?
    var email:String?
    var userId:Int?
    var appleId:String?
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

class DataModels:ObservableObject{

    
    var recipies = [Recipe]()
    
    var networkHandler = NetworkAdapter("http://localhost:5000")
    
    var user = User()
}
