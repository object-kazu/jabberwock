//
//  html.swift
//  JabberWock
//
//  Created by 清水 一征 on 2016/12/01.
//  Copyright © 2016年 momiji-mac. All rights reserved.
//

import Foundation

let INSERTSTRING: String    = "%%"
let INSERT_LANG: String = "lang = " + INSERTSTRING

class HTML:JW {
    var lang            : LANG!
    var charset         : CHARSET!
    var openString      : String = "<html" + SPC + INSERT_LANG + SPC + ">"
    var closeString     : String = "</html>"
    
    override init() {
        lang = LANG.en
        charset = CHARSET.utf8
    }
    
    private func insertLang () {
        // html tagでlangを設定しない場合
        if lang.str() == "" {
            openString = "<html>"
            return
        }
        
        let str = "\"" + lang.str() + "\""
        openString = openString.replacingOccurrences(of: INSERTSTRING, with: str)
    }
    
    override func assemble() {
        insertLang()
        resultString += openString
        resultString += RET
        
        if childString.count > 0 {
            for str in childString {
                resultString += str
                resultString += RET
            }
        }
        
        resultString += closeString
    }
    
    
    
}
