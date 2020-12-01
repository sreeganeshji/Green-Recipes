//
//  recipeThumb1.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 10/31/20.
//

import SwiftUI

struct recipieThumb1: View {
    @Binding var recipe:Recipe
    var body: some View {
        VStack{
        if(recipe.pictures.count>0){
            //display image
        }
            Text(recipe.name).bold()
//            getDescription(recipe: recipe)
            
        }
    }
    func getDescription(recipe:Recipe)->Text{
        let str = recipe.description
        let strlen = str.count
        var descriptionThumb:String
        
        if(strlen>0){
            let start = str.startIndex
            let end = str.index(str.startIndex, offsetBy: .init(20))
            
            let strDistance = str.distance(from: start, to: end)
            if strDistance.magnitude < strlen{
                descriptionThumb = str[start...end] + "..."
            }
            else{
                descriptionThumb = str
            }
            return Text(descriptionThumb)
            
        }
        return Text("")
    }
}

struct recipieThumb1_Previews: PreviewProvider {

    static var previews: some View {
        recipieThumb1(recipe: .constant(.init(name: "Snorkler", description: "Will bring you the best burps on a full moon day.")))
    }
}
