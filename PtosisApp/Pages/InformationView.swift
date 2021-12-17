//
//  InformationView.swift
//  PtosisApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/12/07.
//

import SwiftUI

//変数を定義
struct Informations: View {
    @ObservedObject var user: User
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @State var isSaved = false
    @State private var goTakePhoto: Bool = false  //撮影ボタン
    
    @State var datas = ["item1", "item2", "item3"]
    @State var itemSelection:String?
    
    var body: some View {
        NavigationView{
                Form{
                    HStack{
                        Text("入力日時")
                        Text(self.user.date, style: .date)
                    }
                    
                    //DatePicker("入力日時", selection: $user.date)
                    
                    HStack{
                        Text(" I D ")
                        TextField("idを入力してください", text: $user.id)
                    }.onChange(of: user.id) { _ in
                        self.user.isSendData = false
                        }
                        
                        Picker(selection: $user.selected_surgeon,
                                   label: Text("術者")) {
                            ForEach(0..<user.surgeon.count) {
                                Text(self.user.surgeon[$0])
                                     }
                            }
                           .onChange(of: user.selected_surgeon) { _ in
                               self.user.isSendData = false
                               UserDefaults.standard.set(user.selected_surgeon, forKey:"surgeondefault")
                               }
                    
                        Picker(selection: $user.age,
                               label: Text("年齢")) {
                            ForEach(0..<100){ age in
                                Text("\(age)")
                            }
                        }
                       .onChange(of: user.age) { _ in
                           self.user.isSendData = false
                           }
                
                    
                        Picker(selection: $user.selected_side,
                                   label: Text("側")) {
                            ForEach(0..<user.side.count) {
                                Text(self.user.side[$0])
                                    }
                            }
                            .onChange(of: user.selected_side) { _ in
                                self.user.isSendData = false
                                }
                            .pickerStyle(SegmentedPickerStyle())
                        
                        Picker(selection: $user.selected_procedure,
                                   label: Text("術式")) {
                            ForEach(0..<user.procedure.count) {
                                Text(self.user.procedure[$0])
                                    }
                            }
                           .onChange(of: user.selected_procedure) { _ in
                               self.user.isSendData = false
                               }
                        
                        Picker(selection: $user.selected_timing,
                                   label: Text("タイミング")) {
                            ForEach(0..<user.timing.count) {
                                Text(self.user.timing[$0])
                                    }
                            }
                           .onChange(of: user.selected_timing) { _ in
                               self.user.isSendData = false
                               }
                            
                        HStack{
                            Text("自由記載")
                            TextField("", text: $user.free_description)
                                .keyboardType(.default)
                        }.layoutPriority(1)
                        .onChange(of: user.free_description) { _ in
                        self.user.isSendData = false
                    }
                }.navigationTitle("患者情報入力")
                .onAppear(){
                 }
            }
                
            
            Spacer()
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
               }
                
            ) {
                Text("保存")
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
                .sheet(isPresented: self.$goTakePhoto) {
                     CameraView(user: user)
                }
    }
}
