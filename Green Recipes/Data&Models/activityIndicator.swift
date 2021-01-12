//
//  activityIndicator.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/12/21.
//

import Foundation
import UIKit
import SwiftUI

struct activityIndicator:UIViewRepresentable{
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        var indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator:NSObject{
        
    }
}
