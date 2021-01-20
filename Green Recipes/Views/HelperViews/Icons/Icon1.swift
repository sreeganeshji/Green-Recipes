//
//  Icon1.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/18/21.
//

import SwiftUI

struct Icon1: View {
    var body: some View {

        VStack{
            Image("iconimg")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding(50)
        
        
    }
}

struct Icon1_Previews: PreviewProvider {
    static var previews: some View {
        Icon1()
    }
}
