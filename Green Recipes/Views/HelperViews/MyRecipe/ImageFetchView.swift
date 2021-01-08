//
//  ImageFetchView.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/7/21.
//

import SwiftUI

struct ImageFetchView: View {
    @State var image:UIImage = .init()
    @State var imageKey:String
    @EnvironmentObject var data:DataModels
    var body: some View {
        Image(uiImage: self.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear(){
                getImage()
            }
    }
    
    func getImage(){
        func updateImages(imageData:Data){
            self.image = UIImage(data: imageData)!
        }
        
        //download images
        self.data.photoStore.downloadData(key: self.imageKey, completion: updateImages)
    }
}

//struct ImageFetchView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageFetchView()
//    }
//}
