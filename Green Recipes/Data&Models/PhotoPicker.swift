//
//  PHPicker.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/30/20.
//

import Foundation
import UIKit
import SwiftUI
import PhotosUI

struct PhotoPicker:UIViewControllerRepresentable{
    @Binding var showSheet:Bool
    @Binding var images:[UIImage]
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images]) //filter images
        configuration.selectionLimit = 0 // select multiple images
        
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        
        return controller
    }
    
    class Coordinator:PHPickerViewControllerDelegate{
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.showSheet = false
            for image in results{
                if image.itemProvider.canLoadObject(ofClass: UIImage.self){
                    image.itemProvider.loadObject(ofClass: UIImage.self) { (newImage:NSItemProviderReading?, error:Error?) in
                        if let error = error{
                            print("couldn't load images: \(error.localizedDescription)")
                        }
                        else{
                            if(self.parent.images.count < 5){
                            let image = newImage as! UIImage
//                          print(image.configuration.)
                            let compressedImage = image.jpegData(compressionQuality: 0)
                                let options = [kCGImageSourceCreateThumbnailWithTransform: true, kCGImageSourceCreateThumbnailFromImageAlways: true, kCGImageSourceThumbnailMaxPixelSize: 300] as CFDictionary
                                let CGimageSource = CGImageSourceCreateWithData(compressedImage as! CFData, nil)
                                let imageFromCG = CGImageSourceCreateThumbnailAtIndex(CGimageSource!, 0, options)!
                                let thumbnail = UIImage(cgImage: imageFromCG)
                                
                            
                            self.parent.images.append(thumbnail)
                            }
                        }
                    }
                }
                else{
                    print("The data is not image")
                }
            }
        }
        
        private var parent:PhotoPicker
        
        init(_ parent:PhotoPicker) {
            self.parent = parent
        }
        
       
        
    }
}

