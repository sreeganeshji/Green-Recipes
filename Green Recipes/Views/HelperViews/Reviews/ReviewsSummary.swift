//
//  ReviewsSummary.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/31/20.
//

import SwiftUI

struct ReviewsSummary: View {
    @Binding var user:User
    @Binding var recipe:Recipe
    @Binding var reviews:[Review]
    @EnvironmentObject var data:DataModels
    @State var showSheetAddReview:Bool = false
    @Binding var signedin:Bool
    var fetchReviews:(_ submitAvg:Bool)->()
    
    var body: some View {
//        ScrollView{
        Form{
//        VStack{
            HStack{
    //            Text("Ratings & Reviews")
    //                .font(.title)
    //                .fontWeight(.light)
    //                .foregroundColor(.blue)
    //            HStack{
    //                Text(String(format: "%0.1f out of 5", self.average)).bold()
                StarView(stars: (recipe.rating != nil) ? .constant(recipe.rating!) : .constant(0))
                        .foregroundColor(.yellow)
    //            }
                Spacer()
                Text((recipe.ratingCount != nil) ? "\(recipe.ratingCount!) ratings" : "0 ratings").foregroundColor(.secondary)
            }
            
            if data.user.appleId == ""{
                Button(action:{signedin = false})
                {
                    Text("Sign In")
                }
            }
                else{
            Button(action:{self.showSheetAddReview = true})
            {
                HStack{
                    Text("Write Review")
                    Spacer()
                    Image(systemName: "square.and.pencil")
                }
            }
                }
            ForEach(reviews.reversed(), id:\.self){
                    review in
                    
                    Section{
                    
//                    NavigationLink(destination:ReviewDetail(review: review)){
                        ReviewDetail(review: review).environmentObject(self.data)
//                            .padding()
//                    }
                    }
                    
                }
//            }
        }
        .onAppear(){
            fetchReviews(false)
        }
//        }
        .navigationTitle("Ratings & Reviews")
        .sheet(isPresented: self.$showSheetAddReview, content: {
            NavigationView{
                AddReview(showSheet:self.$showSheetAddReview, user: self.$user, recipe: self.$recipe, fetchReviews: fetchReviews).environmentObject(self.data)
                .padding()
                .navigationTitle("Write Review")
            }
        })
    }
    
}

//struct ReviewsSummary_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewsSummary()
//    }
//}
