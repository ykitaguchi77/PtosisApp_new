//
//  InterviewView.swift
//  PtosisApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/12/13.
//

import SwiftUI

struct PtosisInterview: View {
    @ObservedObject var user = User()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let ansOption = ["耐えられない", "とても気になる", "気になる", "やや気になる", "全く気にならない"]
    //let yesnoOption = ["yes", "no"]
    
    @State var sq1Answer = -1
    @State var sq2Answer = -1
    @State var sq3Answer = -1
    @State var sq4Answer = -1
    @State var sq5Answer = -1
    @State var sq6Answer = -1
    @State var sq7Answer = -1
    @State var sq8Answer = -1
    @State var sq9Answer = -1
    @State var sq10Answer = -1
//    @State var isSaved = false
//    @State var goNext = false

    var body: some View {
//        NavigationLink(destination:ContentView(), isActive: $goNext){
//            EmptyView()
//        }
        
        VStack(spacing:0){
            ScrollView(.vertical){
                
                Text("眼瞼下垂 症状アンケート")
                    .font(.title)
                    .padding()
                
                Text("該当するものにチェックしてください")
                    .font(.title2)
                    .padding(.bottom)
                
                Group{
                    RadioButton(selectedIndex: $sq1Answer, axis: RadioButton.Axis.vertical, title1: "❶ 外見の変化が気になりますか？", title2: "", texts: ansOption)
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 100)
                        .padding()
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                    
                    RadioButton(selectedIndex: $sq2Answer, axis: RadioButton.Axis.vertical, title1: "❷ 眉毛を挙げていないといけないのが疲れますか？", title2: "", texts: ansOption)
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 100)
                        .padding()
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                    
                    RadioButton(selectedIndex: $sq3Answer, axis: RadioButton.Axis.vertical, title1: "❸ 肩が凝りますか？", title2: "", texts: ansOption)
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 100)
                        .padding()
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                    
                    RadioButton(selectedIndex: $sq4Answer, axis: RadioButton.Axis.vertical, title1: "❹ 目が疲れますか？", title2: "", texts: ansOption)
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 100)
                        .padding()
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                    
                    RadioButton(selectedIndex: $sq5Answer, axis: RadioButton.Axis.vertical, title1: "❺ ものを見るときに焦点が合いにくいですか？", title2: "", texts: ansOption)
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 100)
                        .padding()
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                    
                    RadioButton(selectedIndex: $sq6Answer, axis: RadioButton.Axis.vertical, title1: "❻ テレビを見にくいと感じますか？", title2: "", texts: ansOption)
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 100)
                        .padding()
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                    
                    RadioButton(selectedIndex: $sq7Answer, axis: RadioButton.Axis.vertical, title1: "❼ 文字を書いたり手作業をしたりするとき見にくさを感じますか？", title2: "", texts: ansOption)
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 100)
                        .padding()
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                    
                    RadioButton(selectedIndex: $sq8Answer, axis: RadioButton.Axis.vertical, title1: "❽ 上の物を見にくく感じますか？", title2: "", texts: ansOption)
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 100)
                        .padding()
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                    
                    RadioButton(selectedIndex: $sq9Answer, axis: RadioButton.Axis.vertical, title1: "❾ イライラしますか？", title2: "", texts: ansOption)
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 100)
                        .padding()
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                    
                    RadioButton(selectedIndex: $sq10Answer, axis: RadioButton.Axis.vertical, title1: "➓ 寝つきが悪いように感じますか？", title2: "", texts: ansOption)
                        .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 100)
                        .padding()
                        .border(Color.black)
                        .font(.title2)
                        .padding()

                }
                

                Spacer()
                
                Button(action:{
                    ResultHolder.GetInstance().SetSymptomAnswer(sq1: String(sq1Answer), sq2: String(sq2Answer), sq3: String(sq3Answer), sq4: String(sq4Answer), sq5: String(sq5Answer), sq6: String(sq6Answer), sq7: String(sq7Answer), sq8: String(sq8Answer), sq9: String(sq9Answer), sq10: String(sq10Answer))
                    self.user.isPtosisInterview = true
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("保存")
                        .foregroundColor(Color.white)
                        .font(Font.title)
                }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 50)
                .background(Color.black)
                .padding([.top, .leading, .trailing])
                
                

            }
        }
        .background(Color.white)
        .navigationTitle("Question Page")
        .onAppear(){
            sq1Answer = Int(ResultHolder.GetInstance().SymptomAnswers["sq1"]!) ?? -1
            sq2Answer = Int(ResultHolder.GetInstance().SymptomAnswers["sq2"]!) ?? -1
            sq3Answer = Int(ResultHolder.GetInstance().SymptomAnswers["sq3"]!) ?? -1
            sq4Answer = Int(ResultHolder.GetInstance().SymptomAnswers["sq4"]!) ?? -1
            sq5Answer = Int(ResultHolder.GetInstance().SymptomAnswers["sq5"]!) ?? -1
            sq6Answer = Int(ResultHolder.GetInstance().SymptomAnswers["sq6"]!) ?? -1
            sq7Answer = Int(ResultHolder.GetInstance().SymptomAnswers["sq7"]!) ?? -1
            sq8Answer = Int(ResultHolder.GetInstance().SymptomAnswers["sq8"]!) ?? -1
            sq9Answer = Int(ResultHolder.GetInstance().SymptomAnswers["sq9"]!) ?? -1
            sq10Answer = Int(ResultHolder.GetInstance().SymptomAnswers["sq10"]!) ?? -1
        }
    }
}
