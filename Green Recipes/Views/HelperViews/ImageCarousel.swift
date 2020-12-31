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
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight:300)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }

                if self.images.count>0{
                    Button(action:{
                        let N = self.images.count
                        self.images.remove(at: N-1)
                    })
                    {
                        HStack{
                            Text("Remove")
                        Image(systemName: "rectangle.stack.fill.badge.minus")
                        }.foregroundColor(.red)
                    }
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
