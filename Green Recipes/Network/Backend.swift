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
}
