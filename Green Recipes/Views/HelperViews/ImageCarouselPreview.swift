//
//  ImageCarouselPreview.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/31/20.
//

import SwiftUI

struct ImageCarouselPreview: View {
    @Binding var images:[UIImage]
    var body: some View {
        ScrollView(.horizontal){

            HStack{
               
                ForEach(self.images,id:\.self){
                    image in
                    
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight:300)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .padding(.trailing)
                }

                
                
            }
        }
    }
}

struct ImageCarouselPreview_Previews: PreviewProvider {
    static var previews: some View {
        ImageCarouselPreview(images:.constant([UIImage(systemName: "plus.circle")!, UIImage(systemName: "plus.minus")!,UIImage(systemName: "plus.circle")!, UIImage(systemName: "plus.minus")!,UIImage(systemName: "plus.circle")!, UIImage(systemName: "plus.minus")!]))
//        ImageCarousel()
    }
}
