//
//  DialogView.swift
//  WatsPLAN
//
//  Created by Wenjiu Wang on 2020-06-19.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI

struct DialogView: View {
    @EnvironmentObject var model: Model
    @Binding var showDialog: Bool
    @State var tempName = ""
    @Binding var dialogType: Int

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 50)
                Text((dialogType == 0 ? "SAVE" : "DELETE"))
                    .font(.custom("Avenir Next Medium", size:30))
                    .foregroundColor(Color("uwyellow"))
            }
            
            VStack(alignment: .leading) {
                if dialogType == 0 {
                    Text(self.model.fileName == "" ? "Create a new save: " : "Overwrite save file " + self.model.fileName + "?")
                        .font(.custom("Avenir Next Medium", size:20))
                        .foregroundColor(Color.black)
                        .padding([.top, .leading], 20.0)
                } else {
                    Text("Delete save file " + self.model.fileName + "?")
                            .font(.custom("Avenir Next Medium", size:20))
                            .foregroundColor(Color.black)
                            .padding([.top, .leading], 20.0)
                }

                
                if self.model.fileName == "" && self.dialogType == 0 {
                    TextField("Please enter a file name", text: self.$tempName)
                        .padding(.horizontal, 20.0)
                    
                    
                    HStack {
                        Rectangle()
                            .frame(height: 2)
                            .background(Color.black)
                    }
                    .padding(.leading, 20)

                }
                
                HStack(spacing: 30) {
                    Button(action: {
                        self.tempName = ""
                        withAnimation {
                            self.showDialog = false;
                        }
                    }) {
                        Text("NO")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .background(Color.black)
                            .foregroundColor(Color("uwyellow"))
                            .font(.custom("Avenir Next Medium", size:18))

                    }
                    .cornerRadius(10)

                    Button(action: {
                        if self.dialogType == 0{
                            if self.model.fileName == "" && self.tempName != "" {
                                self.model.saveModel(name: self.tempName)
                            } else if self.model.fileName != "" {
                                self.model.saveModel(name: self.model.fileName)
                            } else {
                                //alert user incorrect input
                            }
                            withAnimation {
                                self.showDialog = false;
                            }
                        } else {
                            if self.model.fileName != "" {
                                self.model.deleteFile()
                            }
                            withAnimation {
                                self.showDialog = false;
                            }
                        }
                        
                    }) {
                        Text("YES")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .background(Color.black)
                            .foregroundColor(Color("uwyellow"))
                            .font(.custom("Avenir Next Medium", size:18))

                    }
                    .cornerRadius(10)
                }
                .padding(.leading, 120)
                .padding(.top, 20)
                .padding(.bottom, 10)

            }
            .background(Color("uwyellow"))
        }
        .frame(width: 350)
    }
}

/*
struct DialogView_Previews: PreviewProvider {
    static var previews: some View {
        DialogView()
    }
}
 */
