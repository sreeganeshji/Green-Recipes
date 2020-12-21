//
//  Backend.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 11/24/20.
//

import Foundation

class NetworkAdapter{
    
    var baseURL = URL(string: "https://ganeshappbackend.com")!
    
    init(_ base:String){
        self.baseURL = URL(string:base)!
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
}
