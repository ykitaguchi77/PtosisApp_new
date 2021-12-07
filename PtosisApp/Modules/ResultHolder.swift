//
//  ResultHolder.swift
//  PtosisApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/12/07.
//

import SwiftUI

class ResultHolder{
    init() {}
    
    // インスタンスを保持する必要はなく、すべてのインスタンス変数をstaticにする実装で良いと思います。
    static var instance: ResultHolder?
    public static func GetInstance() -> ResultHolder{
        if (instance == nil) {
            instance = ResultHolder()
        }
        
        return instance!
    }

    /*
    private (set) public var ID = ""
    public func SetID(id: String) -> Bool{
        let isValid = id != ""
        
        if (isValid){
            ID = id
        }
        else{
            print("invalid id!!!")
        }
        
        return isValid
    }
    */
 
 
    private (set) public var Images: [Int:CGImage] = [:]
    public func GetUIImages() -> [UIImage]{
        var uiImages: [UIImage] = []
        let length = Images.count
        for i in 0 ..< length {
            if (Images[i] != nil){
                uiImages.append(UIImage(cgImage: Images[i]! ))
            }
        }
        
        return uiImages
    }
    
    public func SetImage(index: Int, cgImage: CGImage){
        Images[index] = cgImage
    }
    
    
    public func GetImageJsons() -> [String]{
        var imageJsons:[String] = []
        let uiimages = GetUIImages()
        let jsonEncoder = JSONEncoder()
        let length = uiimages.count
        for i in 0 ..< length {
            if (Images[i] != nil){
                let data = PatientImageData()
                
                data.image = uiimages[i].resize(size: ConstHolder.EVALIMAGESIZE)!.pngData()!.base64EncodedString()
                let jsonData = (try? jsonEncoder.encode(data)) ?? Data()
                let json = String(data: jsonData, encoding: String.Encoding.utf8)!
                imageJsons.append(json)
            }
        }
        
        return imageJsons
    }
    
    private (set) public var Answers: [String:String] = ["q1":"", "q2":"", "q3":"", "q4":"", "q5": "", "q6": "", "q7": "", "q8": "", "q9": ""]

    public func SetAnswer(q1:String, q2:String, q3:String, q4:String, q5:String, q6:String, q7:String, q8:String, q9:String){
        Answers["q1"] = q1 //date
        Answers["q2"] = q2 //hashID
        Answers["q3"] = q3 //ID
        Answers["q4"] = q4 //imgNum
        Answers["q5"] = q5 //side
        Answers["q6"] = q6 //surgeon
        Answers["q7"] = q7 //procedure
        Answers["q8"] = q8 //procedure
        Answers["q9"] = q9 //free
    }

    public func GetAnswerJson() -> String{
        let data = QuestionAnswerData()
        data.pq1 = Answers["q1"] ?? ""
        data.pq2 = Answers["q2"] ?? ""
        data.pq3 = Answers["q3"] ?? ""
        data.pq4 = Answers["q4"] ?? ""
        data.pq5 = Answers["q5"] ?? ""
        data.pq6 = Answers["q6"] ?? ""
        data.pq7 = Answers["q7"] ?? ""
        data.pq8 = Answers["q8"] ?? ""
        data.pq9 = Answers["q9"] ?? ""
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        let jsonData = (try? jsonEncoder.encode(data)) ?? Data()
        let json = String(data: jsonData, encoding: String.Encoding.utf8)!
        return json
    }
}

class PatientImageData: Codable{
    var image = ""
}

class QuestionAnswerData: Codable{
    var pq1 = ""
    var pq2 = ""
    var pq3 = ""
    var pq4 = ""
    var pq5 = ""
    var pq6 = ""
    var pq7 = ""
    var pq8 = ""
    var pq9 = ""
}


