//
//  Backend.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 11/24/20.
//

import Foundation

class NetworkAdapter{
    

    
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
    
    func searchRecipeLike(text:String, completion: @escaping ([RecipeTemplate1], Error?)->Void){
        /*
         Returns recipe with properties
         ID, name, and category.
         */
        var fetchURL = baseURL
        
        fetchURL.appendPathComponent("findrecipeslike/\(text)")
        
        var recipeList : [RecipeTemplate1] = []
        
        let task = URLSession.shared.dataTask(with: fetchURL) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
//                print("Couldn't recieve data. Error: \(String(describing: error))")
                completion([],error)
                return
            }
            let decoder = JSONDecoder()
            do{
//                print("Data is: ",String(data:data!,encoding: .utf8))
            recipeList = try decoder.decode([RecipeTemplate1].self, from: data!)
//                print("Recipe is ",recipeList)
                completion(recipeList, nil)
            }
                catch{
                    completion([], error)
//                    print("Couldn't decode error: \(error)")
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
                print("couldn't decode, id:\(id) data:\(String(data:data!, encoding: .utf8)). Error: \(error)")
                return
            }
            completion(recipe)
        }
        
        task.resume()
    }
    
    func getUserWithAppleID(appleID:String,completion:@escaping (User)->()){
        

        
        var reqURL = baseURL
        reqURL.appendPathComponent("getuserwithappleid/\(appleID)")
        
        print("Requesting URL: ",reqURL.absoluteString)
        let task = URLSession.shared.dataTask(with: reqURL) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
                print("server error: \(error)")
                
                print("Url response: \(response)")
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
            }
            completion(user_rec)
        }
        
        task.resume()
    }
    
    
    func createUser(user:User, completion: @escaping (User?, Error?)->()){
        
        var userRec:User?
        
        //encode json
        let encoder = JSONEncoder()
        do{
        let data = try encoder.encode(user)
        var requestURL = baseURL
        requestURL.appendPathComponent("adduser")
        
        var requestObj = URLRequest(url: requestURL)
        
        requestObj.httpMethod = "POST"
        requestObj.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestObj.httpBody = data
            
        //create task
            let task = URLSession.shared.dataTask(with: requestObj) { (data:Data?, response:URLResponse?, error:Error?) in
                if error != nil{
                    print("Session error: \(error)")
                    completion(userRec, error)
                    return
                }
                
                do{
                    let decoder = JSONDecoder()
                    try userRec = decoder.decode(User.self, from: data!)
                }
                catch{
                    print("Couldn't decode recieved user")
                    completion(userRec, error)
                    return
                }
                completion(userRec, nil)
            }
            task.resume()
        }
        catch{
            print("Couldn't encode user: \(error)")
            completion(userRec, error)
            return
        }
    }
    
    func addFavorite(userId:Int, recipeId:Int){
        var requestURL = baseURL
        requestURL.appendPathComponent("addfavorite/\(userId)/\(recipeId)")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            if error != nil{
                print("Couldn't add favorites: \(error)")
            }
        }
        task.resume()
    }
    
    func removeFavorite(userId:Int, recipeId:Int){
        var requestURL = baseURL
        requestURL.appendPathComponent("removefavorite/\(userId)/\(recipeId)")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request)
        {
            _, response, error in
            print("Response is: \(response)")
            if error != nil{
                print("couldn't remove favorite: \(error)")
            }
        }
        
        task.resume()
    }
    
    func getUserFavorites(userId:Int, completion:@escaping ([RecipeTemplate1]?, Error?)->()){
        var requestURL = baseURL
        requestURL.appendPathComponent("getuserfavorites/\(userId)")
        
        let task = URLSession.shared.dataTask(with: requestURL){
            data, response, error in
                
            if error != nil{
                print("Couldn't fetch favorites: \(error)")
                completion(nil, error)
                return
            }
            var recipes:[RecipeTemplate1] = []
            let decoder = JSONDecoder()
            
            do {
                recipes = try decoder.decode([RecipeTemplate1].self, from: data!)
                completion(recipes, nil)
            }
            catch{
                completion(nil, error)
                print("Couldn't decode due to error: \(error)")
            }
        }
        task.resume()
    }
    
    func submitReview(review:Review, completion:@escaping (Error?)->()){
        var requestURL = baseURL
        requestURL.appendPathComponent("submitreview")
        
        //json encode the review and send it to the server
        
        let encoder = JSONEncoder()
        do {
        let jsonData = try encoder.encode(review)
            
        var requestObj = URLRequest(url: requestURL)
        
        requestObj.httpMethod = "POST"
        requestObj.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestObj.httpBody = jsonData
            
        //create task
            let task = URLSession.shared.dataTask(with: requestObj) { (data:Data?, response:URLResponse?, error:Error?) in
                if error != nil{
                    print("Session error: \(error)")
                    completion(error)
                    return
                }
                completion(nil)
            }
            task.resume()
        }
        catch{
            print("Couldn't encode review due to errors: \(error)")
        }
    }
    
    func fetchReviews(recipe_id:Int, completion:@escaping ([Review],Error?, _ callback:@escaping ()->())->(), callback:@escaping()->()){
        var requestURL = baseURL
        requestURL.appendPathComponent("fetchreviews/\(recipe_id)")
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
                print("error is: \(error)")
                completion([], error, callback)
                return
            }
            let decoder = JSONDecoder()
            do{
                var reviews_rec:[Review]
                reviews_rec = try decoder.decode([Review].self, from: data!)
                completion(reviews_rec, nil, callback)
            }
            catch{
                print("Couldn't decode recived reviews: \(error)")
                completion([], error, callback)
                return
            }
        }
        task.resume()
    }
    
    func fetchMyRecipes(userId:Int, completion:@escaping ([RecipeTemplate1],Error?)->()){
        var fetchURL = baseURL
        fetchURL.appendPathComponent("fetchmyrecipes/\(userId)")
        
        let task = URLSession.shared.dataTask(with: fetchURL) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
                print("Couldn't get response error: \(error)")
                completion(.init(), error)
                return
            }
            let decoder = JSONDecoder()
            do{
                var recipes:[RecipeTemplate1]
                recipes = try decoder.decode([RecipeTemplate1].self, from: data!)
                completion(recipes, nil)
            }
            catch{
                print("Couldn't decode error: \(error)")
            }
        }
        task.resume()
    }
    
    func updateRecipe(recipe: Recipe){
        var addRecipeURL = baseURL
        addRecipeURL.appendPathComponent("updaterecipe")
        var addRecipeRequest = URLRequest(url: addRecipeURL)
        
        addRecipeRequest.httpMethod = "PUT"
        addRecipeRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        let data = try! encoder.encode(recipe)
        print(String(data: data,encoding: .utf8)!)
        addRecipeRequest.httpBody = data
        let task = URLSession.shared.dataTask(with: addRecipeRequest) { (data:Data?, response:URLResponse?, error:Error?) in
//            print(String(data: data ?? Data(), encoding: .utf8)!)
//            print("Response",response ?? "")
//            print("Error",error ?? "")
        }
        task.resume()
    }
    
    func updateUserProfile(user:User){
        var addRecipeURL = baseURL
        addRecipeURL.appendPathComponent("updateuserprofile")
        var addRecipeRequest = URLRequest(url: addRecipeURL)
        
        addRecipeRequest.httpMethod = "PUT"
        addRecipeRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        let data = try! encoder.encode(user)
        print(String(data: data,encoding: .utf8)!)
        addRecipeRequest.httpBody = data
        let task = URLSession.shared.dataTask(with: addRecipeRequest) { (data:Data?, response:URLResponse?, error:Error?) in
//            print(String(data: data ?? Data(), encoding: .utf8)!)
//            print("Response",response ?? "")
//            print("Error",error ?? "")
        }
        task.resume()
    }
    
    func fetchMyReview(recipe_id:Int,userId:Int, completion:@escaping (Review,Error?)->()){
        var requestURL = baseURL
        requestURL.appendPathComponent("fetchmyreview/\(recipe_id)/\(userId)")
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
                print("error is: \(error)")
                completion(.init(), error)
                return
            }
            let decoder = JSONDecoder()
            do{
                var reviews_rec:Review
                reviews_rec = try decoder.decode(Review.self, from: data!)
                completion(reviews_rec, nil)
            }
            catch{
                print("Couldn't decode recived reviews: \(error)")
                completion(.init(), error)
                return
            }
        }
        task.resume()
    }
    
    func getUserName(userId:Int, completion:@escaping ((String, Error?)->())){
        var requestURL = baseURL
        requestURL.appendPathComponent("getusername/\(userId)")
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
                print("Couldn't get username")
                return completion("", error)
            }
            let decoder = JSONDecoder()
            let username = try! decoder.decode(String.self, from: data!)
//            let username = String(data: data!, encoding: .utf8)
            completion(username, nil)
        }
        
        task.resume()
    }
    
    func updateMyReview(review:Review, completion:@escaping (Bool)->(), updateAvg:Bool){
        var addRecipeURL = baseURL
        addRecipeURL.appendPathComponent("updatemyreview")
        var addRecipeRequest = URLRequest(url: addRecipeURL)
        
        addRecipeRequest.httpMethod = "PUT"
        addRecipeRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        let data = try! encoder.encode(review)
        print(String(data: data,encoding: .utf8)!)
        addRecipeRequest.httpBody = data
        let task = URLSession.shared.dataTask(with: addRecipeRequest) { (data:Data?, response:URLResponse?, error:Error?) in
            print(String(data: data ?? Data(), encoding: .utf8)!)
            print("Response",response ?? "")
            print("Error",error ?? "")
            completion(updateAvg)
        }
        task.resume()
    }
    
    func deleteMyReview(reviewId:Int, completion: @escaping (Bool)->(), updateAvg:Bool){
        var requestURL = baseURL
        requestURL.appendPathComponent("deletemyreview/\(reviewId)")
        var deleteMyReviewRequest = URLRequest(url: requestURL)
        deleteMyReviewRequest.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: deleteMyReviewRequest) {     (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
                print("Couldn't delete my review")
                
            }
            completion(updateAvg)
        }
        task.resume()
    }
    
    func deleteMyRecipe(recipeId:Int, completion: @escaping ()->()){
        var requestURL = baseURL
        requestURL.appendPathComponent("deletemyrecipe/\(recipeId)")
        var deleteMyReviewRequest = URLRequest(url: requestURL)
        deleteMyReviewRequest.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: deleteMyReviewRequest) {     (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
                print("Couldn't delete my recipe")
                
            }
            completion()
        }
        task.resume()
    }
    
    func submitReport(report:Report, completion:@escaping (Error?)->()){
        var requestURL = baseURL
        requestURL.appendPathComponent("submitreport")
        
        //json encode the review and send it to the server
        
        let encoder = JSONEncoder()
        do {
        let jsonData = try encoder.encode(report)
            
        var requestObj = URLRequest(url: requestURL)
        
        requestObj.httpMethod = "POST"
        requestObj.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestObj.httpBody = jsonData
            
        //create task
            let task = URLSession.shared.dataTask(with: requestObj) { (data:Data?, response:URLResponse?, error:Error?) in
                if error != nil{
                    print("Session error: \(error)")
                    completion(error)
                    return
                }
                completion(nil)
            }
            task.resume()
        }
        catch{
            print("Couldn't encode review due to errors: \(error)")
        }
    }
    
    func fetchRecipesOfCategory(category:String, completion: @escaping ([RecipeTemplate1], Error?)->()){
        var requestURL = baseURL
        requestURL.appendPathComponent("fetchrecipesofcategory/\(category)")
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data:Data?, response:URLResponse?, error:Error?) in
            if (error != nil){
                completion([],error)
                return
            }
            let jsonDecoder = JSONDecoder()
            do{
                let recipes = try jsonDecoder.decode([RecipeTemplate1].self, from: data!)
                completion(recipes, nil)
            }
            catch{
                completion([], error)
                return
            }
        }
        task.resume()
    }

    func updateRecipeRating(recipeID:Int, rating:Double, ratingCount:Int, completion:@escaping ()->()){
        var requestURL = baseURL
        requestURL.appendPathComponent("updatereciperating/\(recipeID)/\(rating)/\(ratingCount)")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            completion()
        }
        task.resume()
    }
    
    func fetchAllRecipes(count:Int, completion:@escaping ([RecipeTemplate1], Error?)->()){
        var requestURL = baseURL
        requestURL.appendPathComponent("fetchallrecipes/\(count)")
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if error != nil{
                completion([], error)
                return
            }
            let decoder = JSONDecoder()
            do{
            let recipes = try decoder.decode([RecipeTemplate1].self, from: data!)
            completion(recipes, nil)
            }
            catch{
                completion([], error)
            }
        }
        task.resume()
    }
    
    func searchRecipeCategory(category:String, text:String, completion:@escaping ([RecipeTemplate1], Error?)->()){
        var requestURL = baseURL
        requestURL.appendPathComponent("fetchrecipesofcategorylike/\(category)/\(text)")
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if error != nil{
                completion([], error)
                return
            }
            let decoder = JSONDecoder()
            do{
            let recipes = try decoder.decode([RecipeTemplate1].self, from: data!)
            completion(recipes, nil)
            }
            catch{
                completion([], error)
            }
        }
        task.resume()
    }
}
