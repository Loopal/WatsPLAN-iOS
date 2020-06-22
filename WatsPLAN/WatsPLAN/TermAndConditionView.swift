//
//  TermAndConditionView.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-21.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct TermAndConditionView: View {
    
    @Binding var shouldPopToRootView: Bool
    
    @Binding var isMenuActive: Bool
    
    @State var termText: String = ""
    
    var db = Firestore.firestore()
    
    func getTermAndCondition() {
        var docRef = db.collection("Term_and_Condition").document("Content_IOS")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.termText = document.data()?["1"].map(String.init(describing:)) ?? "nil"
                //print(field)
            }
            else{
                print("Document does not exist")
            }
        }
    }
    
    var body: some View {
        
        VStack {
            HTMLView(htmlString: $termText)
                .onAppear(perform: getTermAndCondition)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)

    }
}

/*struct TermAndConditionView_Previews: PreviewProvider {
    static var previews: some View {
        TermAndConditionView()
    }
}*/
