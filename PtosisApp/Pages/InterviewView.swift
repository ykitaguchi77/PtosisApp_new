//
//  InterviewView.swift
//  PtosisApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/12/14.
//

import SwiftUI

struct InterviewView: View {
    @ObservedObject var user = User()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var goPtosisInterview: Bool = false  //撮影ボタン
    @State private var goBSDI: Bool = false  //撮影ボタン
    @State private var goGOQOL: Bool = false  //撮影ボタン
    @State private var goDEQS: Bool = false  //撮影ボタン
    
    var body: some View {
        VStack(spacing:0){
            Text("問診票を選択して下さい")
                .font(.largeTitle)
                .padding(.bottom)
            
            Button(action: {
                self.goPtosisInterview = true /*またはself.show.toggle() */

            }) {
                HStack{
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    Text("眼瞼下垂の自覚症状")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$goPtosisInterview) {
                PtosisInterview(user:user)
                //こう書いておかないとmissing as ancestorエラーが時々でる
            }
            
            
            Button(action: {
                self.goBSDI = true /*またはself.show.toggle() */
                
            }) {
                HStack{
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    Text("BSDI")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$goBSDI) {
                //こう書いておかないとmissing as ancestorエラーが時々でる
            }
            
            
            Button(action: {
                self.goGOQOL = true /*またはself.show.toggle() */
            }) {
                HStack{
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    Text("GOQOL")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$goGOQOL) {

            }
            
            Button(action: {
                self.goBSDI = true /*またはself.show.toggle() */
            }) {
                HStack{
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    Text("BSDI")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$goBSDI) {

            }
            
            
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
               }
                
            ) {
                Text("戻る")
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
        }
            
            
    }
}


