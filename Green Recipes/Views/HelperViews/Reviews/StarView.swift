//
//  StarView.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/31/20.
//

import SwiftUI

struct StarView: View {
    @Binding var stars:Double
    var body: some View {
        HStack{
            if(stars >= 1){
                Image(systemName: "star.fill")
            }
            else if(stars < 1){
                if (stars >= 0.5)
                {
                    Image(systemName: "star.leadinghalf.fill")
                }
                else{
                Image(systemName: "star")
                }
            }
            
            if(stars >= 2){
                Image(systemName: "star.fill")
            }
            else if(stars < 2){
                if (stars >= 1.5)
                {
                    Image(systemName: "star.leadinghalf.fill")
                }
                else{
                Image(systemName: "star")
                }
            }
            
            if(stars >= 3){
                Image(systemName: "star.fill")
            }
            else if(stars < 3){
                if (stars >= 2.5)
                {
                    Image(systemName: "star.leadinghalf.fill")
                }
                else{
                Image(systemName: "star")
                }
            }
            
            if(stars >= 4){
                Image(systemName: "star.fill")
            }
            else if(stars < 4){
                if (stars >= 3.5)
                {
                    Image(systemName: "star.leadinghalf.fill")
                }
                else{
                Image(systemName: "star")
                }
            }
            
            if(stars == 5){
                Image(systemName: "star.fill")
            }
            else if(stars < 5){
                if (stars >= 4.5)
                {
                    Image(systemName: "star.leadinghalf.fill")
                }
                else{
                Image(systemName: "star")
                }
            }
            
        }
    }
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        StarView(stars: .constant(4.5))
    }
}
