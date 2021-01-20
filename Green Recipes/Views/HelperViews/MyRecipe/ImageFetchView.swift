//
//  ImageFetchView.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/7/21.
//

import SwiftUI
import Dispatch

struct ImageFetchView: View {
    let queue = DispatchQueue.init(label: "ImageFetch", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global(qos: .userInteractive))
    @Binding var image:ImageContainer
    @EnvironmentObject var data:DataModels
    @State var spin = false
    var completion : ()->()
    
//    let queue = DispatchQueue(label: "ImageFetch1", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
    var body: some View {
        Image(uiImage: self.image.image)
            .resizable()
            .aspectRatio(contentMode: .fill)

    }
    
    
    func getImage(){

        func progresscb(p:Double){
            
        }
      

        DispatchQueue.main.async{
            
            func updateImages(name:String, imageData:Data?){
                if imageData != nil{
                self.image.image = UIImage(data: imageData!)!
                }
                spin = false
                completion()
            }
            //download images
            let storage = AmplifyStorage()
            
            storage.downloadData(key: self.image.name, completion: updateImages, progresscb:progresscb )
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
