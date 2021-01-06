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
    @State var showAlert = false
    @State var alertMessage = ""
    
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
        .foregroundColor(.yellow)
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
            HStack{
            Text("Write review below (Optional)")
                Spacer()
            Text("\(self.reviewBody.count)/1000")
            }
                .foregroundColor(.secondary)
            Divider()
            TextEditor(text: self.$reviewBody)
            
        }
        .alert(isPresented: self.$showAlert, content: {
            .init(title: Text("Could not submit"), message: Text(alertMessage))
        })
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
        if (self.reviewBody.count > 1000){
            alertMessage = "The body exceeds 1000 caracters."
            showAlert = true
            return
        }
        if (self.review.title.count > 200){
            alertMessage = "The title exceeds 200 characters"
            showAlert = true
            return
        }
        
        self.showSheet = false
        self.review.body = self.reviewBody
        self.review.recipeId = self.recipe.id!
        self.review.userId = self.user.userId
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
