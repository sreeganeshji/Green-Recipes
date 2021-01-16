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
    @State var reviewExists = false
    var fetchReviews:(_ submitAvg:Bool)->()
    
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

        .navigationBarItems(leading: VStack{
            if(self.reviewExists)
            {
                Button(action:{
                    validateFields()
                    self.data.networkHandler.deleteMyReview(reviewId: self.review.Id!, completion: fetchReviews, updateAvg:false)
                })
                {
                    Image(systemName: "trash")
                        .font(.headline)
                }
            }
        }, trailing:
                                VStack{
            if(self.reviewExists)
        {
                Button(action:{
                        validateFields()
                        self.data.networkHandler.updateMyReview(review: self.review, completion: fetchReviews, updateAvg:true)}){
                Text("Update")
                    .font(.headline)
            }
            }
        else{
        Button(action:{submitReview()}){
            Text("Send")
                .font(.headline)
        }
            }
                                })
        
        .onAppear(){
            fetchMyReview()
        }
    }
    
    func updateStar(_ rating:Int){
        self.review.rating = rating
    }
    
    
    func validateFields(){
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
        
        if (self.review.title.isEmpty)
        {
            alertMessage = "Title is empty"
            showAlert = true
            return
        }
        
        self.showSheet = false
        if self.reviewBody != ""{
        self.review.body = self.reviewBody
        }
        self.review.recipeId = self.recipe.id!
        self.review.userId = self.user.userId
    }
    
    func submitReview(){
        validateFields()
        self.data.networkHandler.submitReview(review: review, completion: submitted)
    }
    
    func submitted(err:Error?){
        fetchReviews(true)
    }
    
    func fetchMyReview(){
        self.data.networkHandler.fetchMyReview(recipe_id: self.recipe.id!, userId: self.user.userId, completion: updateReview)
    }
    
    func updateReview(review:Review, error:Error?){
        if error != nil{
            print("Couldn't receive review")
            return
        }
        self.review = review
        self.reviewBody = review.body ?? ""
        if self.review.Id != nil{
            //review exists
            self.reviewExists = true
        }
    }
}

//struct AddReview_Previews: PreviewProvider {
//    static var previews: some View {
//        AddReview()
//    }
//}
