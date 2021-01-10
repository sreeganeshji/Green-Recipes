//
//  ImageFetchView.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/7/21.
//

import SwiftUI
import Dispatch

struct ImageFetchView: View {
    let queue = DispatchQueue.init(label: "ImageFetch", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
    @Binding var image:ImageContainer
    @EnvironmentObject var data:DataModels
    @State var spin = false
//    let queue = DispatchQueue(label: "ImageFetch1", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
    var body: some View {
        Image(uiImage: self.image.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear(){
                    getImage()
            }
    }
    
    func getImage(){
        func updateImages(name:String, imageData:Data){
            self.image.image = UIImage(data: imageData)!
            spin = false
        }
        
        //download images
        let storage = AmplifyStorage()

        queue.async{
        storage.downloadData(key: self.image.name, completion: updateImages)
        spin = true
        while(spin)
        {
        
        }
        }
    }
}

//struct ImageFetchView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageFetchView()
//    }
//}
