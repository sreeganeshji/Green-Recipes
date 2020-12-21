//
//  Reviews.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/21/20.
//

import SwiftUI

struct Reviews: View {
    //count for each start rating.
    @State var ratings:[Int] = [3,2,4,9,5]
    var sum:Int{
        var sum = 0
        for i in 0...4{
            sum += ratings[i]
        }
        return sum
    }
    var avgRating :Double{
        
        var totalStars = 0
        for i in 0...4{
            totalStars += ratings[i] * (i+1)
        }
        return Double(totalStars)/Double(self.sum)
    }
    var body: some View {
        VStack{
            Text("Ratings & Reviews").bold()
            HStack{
                Text(String(format: "%0.1f out of 5", avgRating)).bold()
            }
            Text("\(sum) ratings").foregroundColor(.secondary)
            
            HStack{
                Text("Tap to rate:").foregroundColor(.secondary)
            Button(action:{}){
                Image(systemName: "star")
            }
                Button(action:{}){
                    Image(systemName: "star")
                }
                Button(action:{}){
                    Image(systemName: "star")
                }
                Button(action:{}){
                    Image(systemName: "star")
                }
                Button(action:{}){
                    Image(systemName: "star")
                }
            }
        }
    }
    
    func crudStar(){
        
    }
    
    func oneStar(){
        
    }
    func twoStar(){
        
    }
    func threeStar(){
        
    }
    func fourStar(){
        
    }
    func fiveStar(){
        
    }
}

struct Reviews_Previews: PreviewProvider {
    static var previews: some View {
        Reviews()
    }
}
