//
//  CategoryThumb.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/12/21.
//

import SwiftUI

struct CategoryThumb: View {
    @Binding var image:Image
    @Binding var title:String
    var body: some View {
        
        ZStack{
        image
            .resizable()
//            .scaledToFill()
            .aspectRatio(contentMode: .fill)
            .frame(height:200,alignment: .top)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(radius: 10)
            .padding()
            

                    HStack{
                        Text(title)
                            .font(.system(size: 50))
                            .fontWeight(.light)
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.white)
                            .shadow(radius: 30 )
                      
                    }
             

        }
        
      
    }
}

struct CategoryThumb_Previews: PreviewProvider {
    static var previews: some View {
        CategoryThumb(image: .constant(Image("Snacks")), title: .constant("Snacks"))
    }
}
