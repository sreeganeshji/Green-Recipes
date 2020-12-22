//
//  Backend.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 11/24/20.
//

import Foundation

class NetworkAdapter{
    
    var baseURL = URL(string: "")!
    
    init(_ base:String?){
        if base != nil{
        self.baseURL = URL(string:base!)!
        }
    }
    
    func getRequest<T:Decodable>(path:String, handler:@escaping (([T]?)->Void)){
         let requestURL = self.baseURL.appendingPathComponent(path)
        
            let task = URLSession.shared.dataTask(with: requestURL) { (data:Data?, response:URLResponse?, error:Error?) in
                let jsonDecoder = JSONDecoder()
                if let data = data, let items = try? jsonDecoder.decode([T].self, from: data){
                    handler(items)
                }
                else{
                    handler(nil)
                }
            }
            task.resume()
        
    }

    
//    func postRequest<T>(request:URLRequest, handler)
    
    func addRecipe(recipe: Recipe){
        var addRecipeURL = baseURL
        addRecipeURL.appendPathComponent("addrecipe")
        var addRecipeRequest = URLRequest(url: addRecipeURL)
        
        addRecipeRequest.httpMethod = "POST"
        addRecipeRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        let data = try! encoder.encode(recipe)
        print(String(data: data,encoding: .utf8)!)
        addRecipeRequest.httpBody = data
        let task = URLSession.shared.dataTask(with: addRecipeRequest) { (data:Data?, response:URLResponse?, error:Error?) in
            print(String(data: data ?? Data(), encoding: .utf8)!)
            print("Response",response ?? "")
            print("Error",error ?? "")
        }
        print("Starting the task")
        task.resume()
        
    }
    
    // adds a new user or authenticates an old one
    func fetchUser(user: User)->User{
        var fetchUserURL = baseURL
        fetchUserURL.appendPathComponent("fetchuser")
        var fetchUserRequest = URLRequest(url: fetchUserURL)
        
        //set header parameters
        fetchUserRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        fetchUserRequest.httpMethod = "POST"
        let encoder = JSONEncoder()
        let data = try!encoder.encode(user)
        print(String(data:data,encoding:.utf8))
        
        //add to request body
        fetchUserRequest.httpBody = data
        
        var receivedUser = User()
        
        let task = URLSession.shared.dataTask(with: fetchUserRequest) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
                print("Couldn't decode user")
                return
            }
            let decoder = JSONDecoder()
            
            receivedUser = try! decoder.decode(User.self, from: data!)
            
        }
        return receivedUser
    }
    
    func searchRecipeLike(text:String, completion: @escaping ([RecipeTemplate1])->Void){
        /*
         Returns recipe with properties
         ID, name, and category.
         */
        var fetchURL = baseURL
        
        fetchURL.appendPathComponent("findrecipeslike/\(text)")
        
        var recipeList : [RecipeTemplate1] = []
        
        let task = URLSession.shared.dataTask(with: fetchURL) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
                print("Couldn't recieve data. Error: \(String(describing: error))")
                return
            }
            let decoder = JSONDecoder()
            do{
                print("Data is: ",String(data:data!,encoding: .utf8))
            recipeList = try decoder.decode([RecipeTemplate1].self, from: data!)
                print("Recipe is ",recipeList)
                completion(recipeList)
            }
                catch{
                    
                    print("Couldn't decode error: \(error)")
                }
            
            }
        
        task.resume()
        
    }
    
    func searchRecipeWithID(id:Int, completion: @escaping (Recipe)->()){
    //create a request
        var requestURL = baseURL
        requestURL.appendPathComponent("findrecipewithid")
        requestURL.appendPathComponent("\(id)")
        
        var recipe:Recipe = .init()
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
                print("couldn't fetch recipe, error: \(String(describing: error))")
                return
            }
            
            //decode data
            let decoder = JSONDecoder()
            
            do{
                try recipe = decoder.decode(Recipe.self, from: data!)
            }
            catch{
                print("couldn't decode. Error: \(error)")
                return
            }
            completion(recipe)
        }
        
        task.resume()
    }
    
    func getUserWithAppleID(appleID:String,completion:@escaping (User)->()){
        
        var appleID_clean = String(appleID)
        appleID_clean.removeAll { (c:Character) -> Bool in
            if (c == "."){
                return true
            }
            return false
        }
        
        print("appleIDClean ", appleID_clean)
        
        var reqURL = baseURL
        reqURL.appendPathComponent("getuserwithappleid/\(appleID_clean)")
        
        print("Requesting URL: ",reqURL.absoluteString)
        let task = URLSession.shared.dataTask(with: reqURL) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
                print("server error: \(error)")
                return
            }
            
            print("Recieved data: ",String(data: data!, encoding: .utf8))
            
            let decoder = JSONDecoder()
            var user_rec = User()
            do{
                try user_rec = decoder.decode(User.self, from: data!)
            }
            catch{
                print("Couldn't decode with error: \(error)")
                return
            }
            completion(user_rec)
        }
        
        task.resume()
    }
    
}
