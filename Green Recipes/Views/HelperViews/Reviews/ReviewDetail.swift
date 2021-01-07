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
//        ScrollView{
            VStack{
                HStack{
                    if showMore{
                    Text(self.review.title).bold()
                    }
                    else{
                        Text(self.review.title).bold()
                        .lineLimit(1)
                    }
                    Spacer()
                    Text(self.review.created ?? "").foregroundColor(.secondary)
                }
                HStack{
                StarView(stars: Double(review.rating))
                    .foregroundColor(.yellow)
                    Spacer()
                    Text(self.username)
                }
                
                
                if review.body != nil{
                    if (review.body!.count > 100)
                    {
                        if showMore{
                            Text(review.body!)
                        }
                        else{
                        Text(review.body![review.body!.startIndex...review.body!.index(review.body!.startIndex, offsetBy: .init(100))])
                        Button(action:{self.showMore = true}){
                            HStack{
                                Spacer()
                            Text("more")
                                }
                            }
                        }
                    }
                    else{
                        Text(review.body!)
                        if(!self.showMore && self.review.title.count > 10){
                            Button(action:{self.showMore = true}){
                                HStack{
                                    Spacer()
                                Text("more")
                            }
                        }
                    }
                }
            }
            }
            .onAppear(){
                getUserName(userId: self.review.userId)
            }
//        }
    }
    
    func getUserName(userId:Int){
        self.data.networkHandler.getUserName(userId: userId, completion: updateUserName)
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
