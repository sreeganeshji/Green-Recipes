//
//  ReviewShort.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/31/20.
//

import SwiftUI

struct ReviewShort: View {
    @Binding var review:Review
    var body: some View {
        VStack{
            HStack{
                Text(self.review.title).bold()
                Spacer()
                Text(self.review.created.description).foregroundColor(.secondary)
            }
            
            StarView(stars: Double(review.rating))
            
            if review.body != nil{
                Text(review.body!).frame(maxHeight:200)
            }
        }
    }
    
func getUserNameFromId()->String{
        return "Username"
    }
}

//struct ReviewShort_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewShort()
//    }
//}
