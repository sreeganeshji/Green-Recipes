//
//  SearchBarUI.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/7/21.
//

import SwiftUI
import UIKit
import Foundation

struct SearchBarUI:UIViewRepresentable{
    @Binding var text:String
    
    var completion :()->()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: self.$text, completion: completion)
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    func makeUIView(context: Context) -> UISearchBar {
        let searchBarUI = UISearchBar()
        searchBarUI.autocapitalizationType = .none
        searchBarUI.returnKeyType = .search
        searchBarUI.delegate = context.coordinator
        searchBarUI.searchTextField.placeholder = "Enter recipe name"
        searchBarUI.searchBarStyle = .minimal
        return searchBarUI
    }
    
    class Coordinator: NSObject, UISearchBarDelegate{
        @Binding var textCord:String
        var completion :()->()
        
        init(text: Binding<String>, completion :@escaping ()->()){
            _textCord = text
            self.completion = completion
//            completion()
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            searchBar.text = searchText
            self.textCord = searchText
            completion()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.textCord = searchBar.text ?? ""
            completion()
            searchBar.endEditing(true)
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.endEditing(true)
        }
    }
}

//struct SearchBarUI_Preview: PreviewProvider {
//
//    static var previews: some View {
//
//        SearchBarUI(text:.constant(""), completion: .init() )
//
//    }
//}
