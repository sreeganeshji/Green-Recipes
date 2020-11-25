//
//  Backend.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 11/24/20.
//

import Foundation

class NetworkAdapter{
    
    var baseURL = URL(string: "https://ganeshappbackend.com")
    
    init(_ base:String){
        self.baseURL = URL(string:base)
    }
    
    func getRequest<T:Decodable>(path:String, handler:@escaping (([T]?)->Void)){
        if let requestURL = self.baseURL?.appendingPathComponent(path)
        {
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
    }
    
//    func postRequest<T>(request:URLRequest, handler)
}
