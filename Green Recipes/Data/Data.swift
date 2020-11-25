//
//  Data.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/30/20.
//

import Foundation

class DataModels:ObservableObject{
    
    struct Recipe: Hashable, Equatable{
        static func == (lhs: DataModels.Recipe, rhs: DataModels.Recipe) -> Bool {
            return (lhs.name == rhs.name)
        }
        
        var name:String
        var description:String
        var ingredients:[String]
        var process:[String]
        var servings:Int
        var pictures:[String]
        var uuid:Int
        var ratings:Ratings
        var comments:[Comment]
        var origin:String
        var category:String
        init() {
            self.name = ""
            self.process = []
            self.servings = 1
            self.pictures = []
            self.uuid = 0
            self.ratings = Ratings()
            self.comments = []
            self.ingredients = []
            self.description = ""
            self.origin = ""
            self.category = ""
        }
        init(name:String, description:String){
            self.init()
            self.name = name
            self.description = description
        }
    }
    
    struct Comment:Hashable{
        var creator:User
        var body:String
        var uuid:Int
    }
    
    struct User:Hashable,Equatable{
        static func == (lhs: DataModels.User, rhs: DataModels.User) -> Bool {
            return lhs.uuid == rhs.uuid
        }
        var name:String
        var profilePic:String
        var uuid:Int
    }
    
    struct Ratings:Hashable{
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
    
    var recipies = [Recipe]()
}
