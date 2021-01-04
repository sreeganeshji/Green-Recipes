//
//  AddReview.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/31/20.
//

import SwiftUI

struct AddReview: View {
    @Binding var showSheet:Bool
    @Binding var user:User
    @Binding var recipe:Recipe
    @State var review:Review = .init()
    @State var reviewBody:String = ""
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
                if(review.rating > 1){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
            }
            Button(action:{updateStar(3)}){
                if(review.rating > 2){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
            }
            Button(action:{updateStar(4)}){
                if(review.rating > 3){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
            }
            Button(action:{updateStar(5)}){
                if(review.rating > 4){
                    Image(systemName: "star.fill")
                }
                else{
                    Image(systemName: "star")
                }
            }

        }
//            HStack{
//                Text("Title")
//                    .font(.title)
//                    .fontWeight(.light)
//                    .foregroundColor(.blue)
//            TextField("", text: self.$review.title)
//                .border(Color(UIColor.separator), width: 3)
//                .cornerRadius(5)
//        }
//            TextEditor(text: self.$reviewBody)
//                .frame(maxHeight:300)
//                .border(Color(UIColor.separator), width: 3)
//                .cornerRadius(5)
            Divider()
            TextField("Title", text: self.$review.title)
            Divider()
            Text("Write review below (Optional)")
                .foregroundColor(.secondary)
            Divider()
            TextEditor(text: self.$reviewBody)
            
        }
        .navigationBarItems(trailing:
        Button(action:{submitReview()}){
            Text("Send")
                .font(.headline)
        })
        
        .onAppear(){
            fetchMyReview()
        }
    }
    
    func updateStar(_ rating:Int){
        self.review.rating = rating
    }
    
    func submitReview(){
        self.showSheet = false
        self.data.networkHandler.submitReview(review: review)
    }
    
    func fetchMyReview(){
//        self.data.networkHandler.
    }
    
    func updateReview(review:Review, error:Error?){
        if error != nil{
            print("Couldn't submit review")
            return
        }
        self.review = review
    }
}

//struct AddReview_Previews: PreviewProvider {
//    static var previews: some View {
//        AddReview()
//    }
//}
