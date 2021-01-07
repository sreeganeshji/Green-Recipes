//
//  ReviewStarSummary.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/31/20.
//

import SwiftUI

struct ReviewStarSummary: View {
    @Binding var average:Double
    
    var body: some View {
        HStack{
//            Text("Ratings & Reviews")
//                .font(.title)
//                .fontWeight(.light)
//                .foregroundColor(.blue)
//            HStack{
//                Text(String(format: "%0.1f out of 5", self.average)).bold()
                StarView(stars: average)
                    .foregroundColor(.yellow)
//            }
            Spacer()
//            Text("\(self.reviews.count) ratings").foregroundColor(.secondary)
        }

}

}


//struct ReviewStarSummary_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewStarSummary()
//    }
//}
