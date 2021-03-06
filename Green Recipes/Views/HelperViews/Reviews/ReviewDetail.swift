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
    let year :String
    let month:String
    let day:String
    var review:Review
    init(review:Review) {
        self.review = review
        let created = review.created!
        let st = created.startIndex
        year = String(created[created.index(st, offsetBy:2)...created.index(st, offsetBy: 3)])
        month = String(created[created.index(st, offsetBy: 5)...created.index(st, offsetBy: 6)])
        day = String(created[created.index(st, offsetBy: 8)...created.index(st, offsetBy: 9)])
        
    }
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
                    Text("\(month)/\(day)/\(year)").foregroundColor(.secondary)
                }
                .padding(.top)
                HStack{
                    StarView(stars: .constant(Double(review.rating)))
                    .foregroundColor(.yellow)
                    Spacer()
                    Text(self.username)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom)
                
                
                if review.body != nil{
                    if (review.body!.count > 100)
                    {
                        if showMore{
//                            GeometryReader{ reader in
                            Text(review.body!)
//                                .frame(width:reader.size.width,alignment:.leading)
//                            }
                                .padding(.bottom)
                                
                        }
                        else{
//                            GeometryReader{ reader in
                            Text(review.body![review.body!.startIndex...review.body!.index(review.body!.startIndex, offsetBy: .init(100))])
//                                .frame(width:reader.size.width,alignment:.leading)
//                            }

                        Button(action:{self.showMore = true}){
                            HStack{
                                Spacer()
                            Text("more")
                                }
                            }
                        }
                    }
                    else{
                        
                        if(!self.showMore && self.review.title.count > 20){
//                            GeometryReader{ reader in
                            Text(review.body!)
//                                .frame(width:reader.size.width,alignment:.leading)
//                            }

                            Button(action:{self.showMore = true}){
                                HStack{
                                    Spacer()
                                Text("more")
                            }
                        }
                    }
                        else{
//                            GeometryReader{ reader in
                            Text(review.body!)
//                                .frame(width:reader.size.width,alignment:.leading)
//                            }
                            .padding(.bottom)
                            .padding(.bottom)
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
