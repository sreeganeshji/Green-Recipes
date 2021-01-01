//
//  ReviewStarSummary.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 12/31/20.
//

import SwiftUI

struct ReviewStarSummary: View {
    @Binding var reviews:[Review]
    @State var average:Double = 0
    
    var body: some View {
        HStack{
//            Text("Ratings & Reviews")
//                .font(.title)
//                .fontWeight(.light)
//                .foregroundColor(.blue)
//            HStack{
//                Text(String(format: "%0.1f out of 5", self.average)).bold()
                StarView(stars: average)
//            }
            Spacer()
            Text("\(self.reviews.count) ratings").foregroundColor(.secondary)
        }
            .onAppear(){
                updateAverage()
    }
}
    func updateAverage(){
        let total:Double = reviews.reduce(0.0) { (result:Double, review:Review) -> Double in
            result + Double(review.rating)
        }
        let average = total/Double(reviews.count)
        self.average = average
    }
}


//struct ReviewStarSummary_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewStarSummary()
//    }
//}
