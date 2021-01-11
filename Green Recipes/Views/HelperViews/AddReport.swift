//
//  AddReport.swift
//  Green Recipes
//
//  Created by SreeGaneshji Bangalore Chandrashekar on 1/10/21.
//

import SwiftUI

struct AddReport: View {
    @Binding var showSheet:Bool
    @Binding var report:Report
    @State var reportBody:String = ""
    @EnvironmentObject var data:DataModels
    @State var showAlert = false
    @State var alertMessage = ""
    @State var reviewExists = false
    @State var alertTitle = ""

    
    var body: some View {
        NavigationView{
        VStack{

            TextField("Report Title", text: self.$report.title)
            Divider()
            HStack{
            Text("Write more details below (Optional)")
                Spacer()
            Text("\(self.reportBody.count)/1000")
            }
                .foregroundColor(.secondary)
            Divider()
            TextEditor(text: self.$reportBody)
            
        }
        .navigationTitle("Report Recipe")
        .padding()
        .navigationBarItems(trailing: Button(action:{validateFields()}){Text("Submit")})
        .alert(isPresented: self.$showAlert, content: {
            .init(title: Text(alertTitle), message: Text(alertMessage), primaryButton: .default(Text("Okay"), action: {submitReport()}), secondaryButton: .cancel(Text("Cancel")))
        })

        }
    }

    
    func validateFields(){
        self.alertTitle = "Could not submit"
        if (self.reportBody.count > 1000){
            alertMessage = "The body exceeds 1000 caracters."
            showAlert = true
            return
        }
        if (self.report.title.count > 200){
            alertMessage = "The title exceeds 200 characters"
            showAlert = true
            return
        }
        
        if (self.report.title.isEmpty)
        {
            alertMessage = "Title is empty"
            showAlert = true
            return
        }
        
        alertTitle = "Confirm Submission"
        alertMessage = "Are you sure you want to send this report?"
        showAlert = true
    }
    
    func submitReport(){
        showSheet = false
        self.data.networkHandler.submitReport(report:report, completion: submitted)
    }
    
    func submitted(err:Error?){
        if err != nil{
            print("Error submitting report \(err)")
        }
        report = .init()
        reportBody = ""
    }
    
}

//struct AddReview_Previews: PreviewProvider {
//    static var previews: some View {
//        AddReview()
//    }
//}


//struct AddReport_Previews: PreviewProvider {
//    static var previews: some View {
//        AddReport()
//    }
//}
