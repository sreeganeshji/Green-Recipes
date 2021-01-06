//
//  ReviewDetail.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/31/20.
//

import SwiftUI

struct ReviewDetail: View {
    @EnvironmentObject var data:DataModels
    @State var username:String = ""
    @State var showMore:Bool = false
    let LessLetterCount = 30
    var review:Review
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text(self.review.title).bold()
                    Spacer()
                    Text(self.review.created ?? "").foregroundColor(.secondary)
                }
                HStack{
                StarView(stars: Double(review.rating))
                    Text(getUserName(userId: self.review.userId))
                }
                
                
                if review.body != nil{
                    if (review.body!.count > 30)
                    {
                        Text(review.body![review.body!.startIndex...review.body!.index(review.body!.startIndex, offsetBy: .init(30))])
                        Button(action:{self.showMore = true}){
                            Text("more")}
                    }
                    Text(review.body!)
                }
            }
        }
    }
    
    func getUserName(userId:Int)->String{
        self.data.networkHandler.getUserName(userId: userId, completion: updateUserName)
        return "Username"
    }
    
    func updateUserName(username:String, error:Error?){
        self.username = username
    }
}

struct ReviewDetail_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetail(review: .init()).environmentObject(DataModels())
    }
}
