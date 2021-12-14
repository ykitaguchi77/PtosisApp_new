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
    
    
    //基本情報
    private (set) public var Answers: [String:String] = ["bq1":"", "bq2":"", "bq3":"", "bq4":"", "bq5": "", "bq6": "", "bq7": "", "bq8": "", "bq9": ""]

    public func SetBasicAnswer(bq1:String, bq2:String, bq3:String, bq4:String, bq5:String, bq6:String, bq7:String, bq8:String, bq9:String){
        Answers["bq1"] = bq1 //date
        Answers["bq2"] = bq2 //hashID
        Answers["bq3"] = bq3 //ID
        Answers["bq4"] = bq4 //imgNum
        Answers["bq5"] = bq5 //side
        Answers["bq6"] = bq6 //surgeon
        Answers["bq7"] = bq7 //procedure
        Answers["bq8"] = bq8 //procedure
        Answers["bq9"] = bq9 //free
    }

    public func GetBasicAnswerJson() -> String{
        let data = BasicQuestionAnswerData()
        data.bq1 = Answers["bq1"] ?? ""
        data.bq2 = Answers["bq2"] ?? ""
        data.bq3 = Answers["bq3"] ?? ""
        data.bq4 = Answers["bq4"] ?? ""
        data.bq5 = Answers["bq5"] ?? ""
        data.bq6 = Answers["bq6"] ?? ""
        data.bq7 = Answers["bq7"] ?? ""
        data.bq8 = Answers["bq8"] ?? ""
        data.bq9 = Answers["bq9"] ?? ""
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        let jsonData = (try? jsonEncoder.encode(data)) ?? Data()
        let json = String(data: jsonData, encoding: String.Encoding.utf8)!
        return json
    }
    
    
    
    //症状アンケート
    private (set) public var SymptomAnswers: [String:String] = ["sq1":"", "sq2":"", "sq3":"", "sq4":"", "sq5": "", "sq6": "", "sq7": "", "sq8": "", "sq9": "", "sq10": ""]

        public func SetSymptomAnswer(sq1:String, sq2:String, sq3:String, sq4:String, sq5:String, sq6:String, sq7:String, sq8:String, sq9:String, sq10:String){
            Answers["sq1"] = sq1
            Answers["sq2"] = sq2
            Answers["sq3"] = sq3
            Answers["sq4"] = sq4
            Answers["sq5"] = sq5
            Answers["sq6"] = sq6
            Answers["sq7"] = sq7
            Answers["sq8"] = sq8
            Answers["sq9"] = sq9
            Answers["sq10"] = sq10
        }

        public func GetSymptomAnswerJson() -> String{
            let data = SymptomQuestionAnswerData()
            data.sq1 = Answers["sq1"] ?? ""
            data.sq2 = Answers["sq2"] ?? ""
            data.sq3 = Answers["sq3"] ?? ""
            data.sq4 = Answers["sq4"] ?? ""
            data.sq5 = Answers["sq5"] ?? ""
            data.sq6 = Answers["sq6"] ?? ""
            data.sq7 = Answers["sq7"] ?? ""
            data.sq8 = Answers["sq8"] ?? ""
            data.sq9 = Answers["sq9"] ?? ""
            data.sq10 = Answers["sq10"] ?? ""
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

class BasicQuestionAnswerData: Codable{
    var bq1 = ""
    var bq2 = ""
    var bq3 = ""
    var bq4 = ""
    var bq5 = ""
    var bq6 = ""
    var bq7 = ""
    var bq8 = ""
    var bq9 = ""
}

class SymptomQuestionAnswerData: Codable{
    var sq1 = ""
    var sq2 = ""
    var sq3 = ""
    var sq4 = ""
    var sq5 = ""
    var sq6 = ""
    var sq7 = ""
    var sq8 = ""
    var sq9 = ""
    var sq10 = ""
}


