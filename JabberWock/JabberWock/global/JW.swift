//
//  JW.swift
//  JabberWock
//
//  Created by 清水 一征 on 2016/12/03.
//  Copyright © 2016年 momiji-mac. All rights reserved.
//

import Foundation




class JW {
    var openString      : String = ""
    var closeString     : String = ""
    
    var resultString: String   = ""
    var childString : [String] = []
    

    func addMember(member:String)  {
        childString.append(member)
    }
    
    func addMember (member: JW){
        resultString += RET
        member.assemble()
        resultString += member.resultString
    }
    
    // add tab for indent
    func addTab (str: String) -> String {
        return TAB + str
    }
    
    func addChild (child : JW){
        child.assemble()
        self.addCihld(child: child.resultString)
    }
    
    func addCihld (child: String) {
        let t = child.replacingOccurrences(of: RET, with: RET + TAB)
        childString.append(addTab(str: t))
    }

    func assemble() {
        assembleCore()
    }
        
    func assembleCore() {
        resultString += openString
        
        if childString.count > 0 {
            resultString += RET
            for str in childString {
                resultString += str
                resultString += RET
            }
        }
       
        if closeString != NO_CLOSETAG {
            resultString += closeString
        }
    }
    
    // ファイルに書き出す
    func press ()  {
        // prep resultString
        assemble()
        
        // ドキュメントパス
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        // 保存するもの
        let fileObject = resultString
        // ファイル名
        let fileName = "result.txt"
        // 保存する場所
        let filePath = documentsPath + fileName
        
        // 保存処理
        do {
            try fileObject.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Fail to write result at text file")
            
        }
        
        //file exist
        let fileManager = FileManager.default
        let path = "/Users/shimizukazuyuki/Desktop/result.txt"
        
        if fileManager.fileExists(atPath: path){
            // remove file
            print("file remove!")
            removeFile(path: path)
        }
        
        // file move
        do{
            try fileManager.moveItem(atPath: filePath, toPath:path)
        } catch {
            assertionFailure("move error")
        }
    }
    
    
    func removeFile(path:String){
        let fileManager = FileManager.default

        do {
            try fileManager.removeItem(atPath: path)
            print("Removal successful")
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
 }