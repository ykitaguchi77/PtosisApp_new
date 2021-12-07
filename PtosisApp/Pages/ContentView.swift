//
//  ContentView.swift
//  PtosisApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/04/18.
//
//写真Coredata参考サイト：https://tomato-develop.com/swiftui-camera-photo-library-core-data/
//
import SwiftUI
import CoreData

//変数を定義
class User : ObservableObject {
    @Published var date: Date = Date()
    @Published var id: String = ""
    @Published var hashid: String = ""
    @Published var age: Int = 0
    @Published var selected_side: Int = 0
    @Published var selected_surgeon: Int = 0
    @Published var selected_procedure: Int = 0
    @Published var selected_timing: Int = 0
    @Published var free_description: String = ""
    @Published var side: [String] = ["", "右", "左", "両"]
    @Published var surgeon: [String] = ["", "野田", "鄭", "加藤", "北口"]
    @Published var procedure: [String] = ["", "<<眼瞼下垂>>","挙筋腱膜前転", "挙筋群前転", "ミュラー筋タッキング(MMCR)","前頭筋吊り上げ", "", "<<皮膚弛緩>>", "上眼瞼皮膚切除", "眉毛下皮膚切除", "分類不能（自由記載）"]
    @Published var timing: [String] = ["", "術前","術翌日", "１週間後", "1ヶ月後","2ヶ月後", "3ヶ月後", "6ヶ月後", "1年後", "その他（自由記載）"]
    @Published var imageNum: Int = 0 //写真の枚数（何枚目の撮影か）
    @Published var isNewData: Bool = false
    @Published var isSendData: Bool = false
    }


struct ContentView: View {
    @ObservedObject var user = User()
    //CoreDataの取り扱い
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.newdate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var goTakePhoto: Bool = false  //撮影ボタン
    @State private var isPatientInfo: Bool = false  //患者情報入力ボタン
    @State private var goSendData: Bool = false  //送信ボタン
    @State private var savedData: Bool = false  //送信ボタン
    @State private var newPatient: Bool = false  //送信ボタン
    
    
    
    var body: some View {
        VStack(spacing:0){
            Text("Ptosis app")
                .font(.largeTitle)
                .padding(.bottom)
            
            Image("ptosis")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            Button(action: { self.isPatientInfo = true /*またはself.show.toggle() */ }) {
                HStack{
                    Image(systemName: "info.circle")
                    Text("患者情報入力")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$isPatientInfo) {
                Informations(user: user)
                //こう書いておかないとmissing as ancestorエラーが時々でる
            }
            
            Button(action: {
                self.goTakePhoto = true /*またはself.show.toggle() */
                self.user.isSendData = false //撮影済みを解除
            }) {
                HStack{
                    Image(systemName: "camera")
                    Text("撮影")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$goTakePhoto) {
                CameraView(user: user)
            }
            

            //送信するとボタンの色が変わる演出
            if self.user.isSendData {
                Button(action: {self.goSendData = true /*またはself.show.toggle() */}) {
                    HStack{
                        Image(systemName: "square.and.arrow.up")
                        Text("送信済み")
                    }
                        .foregroundColor(Color.white)
                        .font(Font.largeTitle)
                }
                    .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                    .background(Color.blue)
                    .padding()
                .sheet(isPresented: self.$goSendData) {
                    SendData(user: user)
                }
            } else {
                Button(action: { self.goSendData = true /*またはself.show.toggle() */ }) {
                    HStack{
                        Image(systemName: "square.and.arrow.up")
                        Text("送信")
                    }
                        .foregroundColor(Color.white)
                        .font(Font.largeTitle)
                }
                    .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                    .background(Color.black)
                    .padding()
                .sheet(isPresented: self.$goSendData) {
                    SendData(user: user)
                }
            }
            
            HStack{
            Button(action: { self.savedData = true /*またはself.show.toggle() */ }) {
                HStack{
                    Image(systemName: "folder")
                    Text("リスト")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:200, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$savedData) {
                SavedData(user: user)
            }
            
            Button(action: { self.newPatient = true /*またはself.show.toggle() */ }) {
                HStack{
                    Image(systemName: "stop.circle")
                    Text("次患者")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
            .alert(isPresented:$newPatient){
                Alert(title: Text("データをクリアしますか？"), primaryButton:.default(Text("はい"),action:{
                    //データの初期化
                    self.user.date = Date()
                    self.user.id = ""
                    self.user.imageNum = 0
                    self.user.selected_side = 0
                    self.user.selected_surgeon = 0
                    self.user.selected_procedure = 0
                    self.user.selected_timing = 0
                    self.user.free_description = ""
                    self.user.isSendData = false
                    
                }),
                      secondaryButton:.destructive(Text("いいえ"), action:{}))
                }
                .frame(minWidth:0, maxWidth:200, minHeight: 75)
                .background(Color.black)
                .padding()
            }
        }
    }
}
