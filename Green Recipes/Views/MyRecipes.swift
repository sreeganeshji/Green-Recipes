//
//  myRecipe.swift
//  Green Recipes
//
//  Created by SreeGaneshji on 11/30/20.
//

import SwiftUI
/*
 Fetch my recipes and add new recipes.
 */

struct MyRecipes: View {
    @State var showSheet = false
    @EnvironmentObject var data: DataModels
    @State var navigationTitle:Binding<String>
    @State var myRecipes:[RecipeTemplate1] = []
    @State var loading = true
    @Binding var signedin:Bool
    
    var body: some View {
        if data.user.appleId == ""{
            Button(action:{signedin = false})
            {
                Text("Sign In")
                    .foregroundColor(.blue)
                    .font(.title)
                    .fontWeight(.light)
            }
            .navigationTitle("My Recipes")
        }
        else if loading{
            VStack{
            Text("Loading")
                .foregroundColor(.blue)
                .font(.title)
                .fontWeight(.light)
                
                activityIndicator()
                    .onAppear(){
            //            self.navigationTitle.wrappedValue = "My Recipes"
                            fetchMyRecipes()
                    }
            }
            .navigationTitle("My Recipes")
        }
        else if (myRecipes.count == 0){
            Text("Add your recipes.")
                .navigationTitle("My Recipes")
                .navigationBarItems(trailing: NavigationLink(destination:AddRecipe().environmentObject(self.data)
                                                                                    .onDisappear(){
                                                                                        fetchMyRecipes()
                                                                                    }
                ){Image(systemName: "square.and.pencil").font(.headline)})
                    .sheet(isPresented: self.$showSheet) {
                        AddRecipe().environmentObject(self.data)
                    }
        }
        else{

        Form{
//            NavigationLink(destination:AddRecipe().environmentObject(self.data)){
////            HStack{
////                Text("Add recipe").bold()
////                Spacer()
////                Image(systemName: "square.and.pencil")
////                    .foregroundColor(.blue)
////                }
                ForEach(myRecipes, id:\.self){
                    recipe in
                    NavigationLink(destination:MyRecipeDetail(recipeSummary:recipe).environmentObject(self.data))
                    {
                        
                        HStack{
                        Text(recipe.name)
                            Spacer()
                            Text(String(format: "%0.1f",recipe.rating ?? 0)).font(.footnote)
                                .padding(-3)
                            Image(systemName: "star.fill").foregroundColor(.yellow).font(.footnote)
                                .padding(-3)
                            Text(String("(\(recipe.ratingCount ?? 0))")).font(.footnote)
                                .padding(EdgeInsets(top: -3, leading: -3, bottom: -3, trailing: 0))
                
                        }
 
                        }
                    }
                .onDelete(perform: { indexSet in
                    for index in indexSet{
                        let recipe = myRecipes[index]
//                        print("Will Delete \(recipe.name)")
                        //delete the images
                        /*
                         1. fetch recipe images
                         2. delete images
                         */
                        data.networkHandler.searchRecipeWithID(id: recipe.id, completion: deleteHandler)
                        myRecipes.remove(at: index)
                    }
                })
                }
//            }
        
//
        .navigationTitle("My Recipes")
        .navigationBarItems(leading:EditButton().font(.headline), trailing: NavigationLink(destination:AddRecipe().environmentObject(self.data)
                                                                            .onDisappear(){
                                                                                fetchMyRecipes()
                                                                            }
        ){Image(systemName: "square.and.pencil").font(.headline)})
            .sheet(isPresented: self.$showSheet) {
                AddRecipe().environmentObject(self.data)
            }
        }
        

    }
    
    func fetchMyRecipes(){
        self.data.networkHandler.fetchMyRecipes(userId: self.data.user.userId, completion: updateMyRecipes)
    }
    
    func updateMyRecipes(recipes:[RecipeTemplate1], err:Error?){
        loading = false
        if err != nil{
            print("Error fetching my recipes \(err!)")
            return
        }
        self.myRecipes = recipes
        
    }
    func deleteHandler(recipe:Recipe){
       
        if recipe.images != nil{
            let amplify = AmplifyStorage()
        for image in recipe.images!{
            amplify.deleteData(key: image)
        }
        }
        self.data.networkHandler.deleteMyRecipe(recipeId: recipe.id!) {}

    }
}

//struct myRecipe_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            MyRecipes(navigationTitle: .constant("My Recipes")).environmentObject(DataModels())
//        }
//    }
//}
