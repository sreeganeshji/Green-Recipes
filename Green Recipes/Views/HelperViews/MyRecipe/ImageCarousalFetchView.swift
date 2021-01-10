//
//  ImageCarousalFetchView.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/7/21.
//

import SwiftUI

struct ImageCarousalFetchView: View {
    @EnvironmentObject var data:DataModels
    @Binding var images:[ImageContainer]
    var body: some View {
        ScrollView(.horizontal){

            HStack{
               
                ForEach(images.indices,id:\.self){
                    i in
                    
                    ImageFetchView(image: $images[i]).environmentObject(self.data)

                        .frame(maxHeight:300)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
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


