//
//  ImageCarousalFetchView.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/7/21.
//

import SwiftUI

struct ImageCarousalFetchView: View {
    @EnvironmentObject var data:DataModels
    @Binding var imageKeys:[String]
    var body: some View {
        ScrollView(.horizontal){

            HStack{
               
                ForEach(self.imageKeys,id:\.self){
                    imageKey in
                    
                    ImageFetchView(imageKey: imageKey).environmentObject(self.data)

                        .frame(maxHeight:300)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }

                if self.imageKeys.count>0{
                    Button(action:{
                        let N = self.imageKeys.count
                        self.imageKeys.remove(at: N-1)
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


