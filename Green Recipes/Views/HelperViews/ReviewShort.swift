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
            HStack{
                if(review.rating > 0){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
                if(review.rating > 1){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
                if(review.rating > 2){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
                if(review.rating > 3){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
                if(review.rating > 4){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
                
                Spacer()
                Text(getUserNameFromId()).foregroundColor(.secondary)
            }
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
