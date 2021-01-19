//
//  Icon1.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/18/21.
//

import SwiftUI

struct Icon1: View {
    var body: some View {
        GeometryReader{
            reader in
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(height:reader.size.height*0.5)
        }
        }
        .frame(width:300, height:300)
    }
}

struct Icon1_Previews: PreviewProvider {
    static var previews: some View {
        Icon1()
    }
}
