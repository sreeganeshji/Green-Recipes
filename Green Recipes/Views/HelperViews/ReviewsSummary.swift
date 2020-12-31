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
    @State var reviews:[Review] = []
    @EnvironmentObject var data:DataModels
    
    var body: some View {
        VStack{
            ReviewStarSummary(reviews: self.$reviews)
            AddReview(user: self.$user, recipe: self.$recipe).environmentObject(self.data)
            Form{
                ForEach(reviews, id:\.self){
                    review in
                    
                    Section{
                        ReviewShort(review: .constant(review)).environmentObject(self.data)
                    }
                    
                }
            }
        }
    }
    
    func fetchReviews(){
        //use the recipe id to find the reviews.
    }
}

//struct ReviewsSummary_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewsSummary()
//    }
//}
