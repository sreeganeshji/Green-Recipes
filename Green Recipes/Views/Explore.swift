//
//  Explore.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/12/21.
//

import SwiftUI

struct Explore: View {
    var body: some View {
        ScrollView(){
            CategoryThumb(image:.constant(Image("Snacks")), title: .constant("Snacks"))
            CategoryThumb(image:.constant(Image("Drinks")), title: .constant("Drinks"))
            CategoryThumb(image:.constant(Image("Desserts")), title: .constant("Desserts"))
            CategoryThumb(image:.constant(Image("Salads")), title: .constant("Salads"))
            CategoryThumb(image:.constant(Image("Lunch")), title: .constant("Lunch"))
            CategoryThumb(image:.constant(Image("Soup2")), title: .constant("Soups"))
        }
    }
}

struct Explore_Previews: PreviewProvider {
    static var previews: some View {
        Explore()
    }
}
