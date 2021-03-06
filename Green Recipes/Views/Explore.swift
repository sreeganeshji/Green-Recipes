//
//  Explore.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/12/21.
//

import SwiftUI

struct Explore: View {
    let categories = ["Snacks", "Drinks", "Desserts", "Lunch", "Salads", "Soups"]
    @EnvironmentObject var data:DataModels
    @Binding var signedin:Bool
    var body: some View {
        ScrollView(){
            ForEach(categories, id:\.self){
                category in
                NavigationLink(destination:CategoryList(categoryName: category, signedin: $signedin).environmentObject(data)){
                CategoryThumb(image:.constant(Image(category)), title: .constant(category))
                }
            }
            NavigationLink(destination:CategoryOthersList(categoryName: "Others", signedin: $signedin).environmentObject(data)){
            CategoryThumb(image:.constant(Image("Others")), title: .constant("Others"))
            }
            
//            CategoryThumb(image:.constant(Image("Snacks")), title: .constant("Snacks"))
//            CategoryThumb(image:.constant(Image("Drinks")), title: .constant("Drinks"))
//            CategoryThumb(image:.constant(Image("Desserts")), title: .constant("Desserts"))
//            CategoryThumb(image:.constant(Image("Salads")), title: .constant("Salads"))
//            CategoryThumb(image:.constant(Image("Lunch2")), title: .constant("Lunch"))
//            CategoryThumb(image:.constant(Image("Soup2")), title: .constant("Soups"))
        }
        .navigationBarHidden(true)
    }
}

//struct Explore_Previews: PreviewProvider {
//    static var previews: some View {
//        Explore()
//    }
//}
