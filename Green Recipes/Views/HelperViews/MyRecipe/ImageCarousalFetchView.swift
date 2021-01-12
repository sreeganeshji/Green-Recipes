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
    @Binding var imagesLoaded:Bool
    @State var doneCount = 0
    
    var body: some View {
        ScrollView(.horizontal){

            HStack{
               
                ForEach(images.indices,id:\.self){
                    i in
                    
                    ImageFetchView(image: $images[i], completion:completion).environmentObject(self.data)

                        .frame(maxHeight:300)
//                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
//                        .padding(-3)
                }

//                if self.images.count>0{
//                    Button(action:{
//                        let N = self.images.count
//                        self.images.remove(at: N-1)
//                    })
//                    {
//                        HStack{
//                            Text("Remove")
//                        Image(systemName: "rectangle.stack.fill.badge.minus")
//                        }.foregroundColor(.red)
//                    }
//                }
                
            }
        }
    }
    
    func completion(){
        doneCount += 1
        if doneCount == images.count{
            imagesLoaded = true
        }
    }
}


