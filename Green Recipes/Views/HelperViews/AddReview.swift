//
//  AddReview.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/31/20.
//

import SwiftUI

struct AddReview: View {
    @Binding var user:User
    @Binding var recipe:Recipe
    @State var review:Review = .init()
    @State var reviewBody:String = "Optional"
    @EnvironmentObject var data:DataModels
    
    var body: some View {
        VStack{
        HStack{
            Text("Tap to rate:").foregroundColor(.secondary)
            Button(action:{updateStar(1)}){
            if(review.rating > 0){
                Image(systemName: "star.fill")
            }
            else{
                Image(systemName: "star")
            }
        }
            Button(action:{updateStar(2)}){
                if(review.rating > 0){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
            }
            Button(action:{updateStar(3)}){
                if(review.rating > 0){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
            }
            Button(action:{updateStar(4)}){
                if(review.rating > 0){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
            }
            Button(action:{updateStar(5)}){
                if(review.rating > 0){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
            }
            Spacer()
            Button(action:{}){
                Text("Submit")
            }
        }
            TextEditor(text: self.$reviewBody).frame(minHeight: 100, maxHeight:300)
        }
        
    }
    
    func updateStar(_ rating:Int){
        self.review.rating = rating
    }
    
    func submitReview(){
        
    }
}

//struct AddReview_Previews: PreviewProvider {
//    static var previews: some View {
//        AddReview()
//    }
//}
