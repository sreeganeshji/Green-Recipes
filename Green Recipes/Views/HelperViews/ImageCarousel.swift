//
//  ImageCarousel.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/30/20.
//

import SwiftUI

struct ImageCarousel: View {
    @Binding var images:[UIImage]
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(self.images,id:\.self){
                    image in
                    Image(uiImage: image)
                }
            }
        }
    }
}

struct ImageCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ImageCarousel(images:.constant([UIImage(systemName: "plus.circle")!, UIImage(systemName: "plus.minus")!,UIImage(systemName: "plus.circle")!, UIImage(systemName: "plus.minus")!,UIImage(systemName: "plus.circle")!, UIImage(systemName: "plus.minus")!]))
//        ImageCarousel()
    }
}
