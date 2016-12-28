//
//  heading.swift
//  JabberWock
//
//  Created by kazuyuki shimizu on 2016/12/15.
//  Copyright © 2016年 momiji-mac. All rights reserved.
//

import Foundation

class HEADING : JW {
    // h1 ~ h6
    var level:      Int     = 1
    var content :  String   = ""

    override init() {
        super.init()
        
        self.openString = "<h" + INSERTSTRING + ">"
        self.closeString = "</h" + INSERTSTRING + ">"
        
    }

    init(level: Int, content: String) {
        super.init()
        self.content = content
        self.level = level
        
    }

    
    private func insertLevel () {
        if level < 1 {
            level = 1
        }
        
        if level > 6 {
            level = 6
        }
        
        openString = openString.replacingOccurrences(of: INSERTSTRING, with: "\(self.level)")
        closeString = closeString.replacingOccurrences(of: INSERTSTRING, with: "\(self.level)")
        
    }
    
    private func insertContent () {
        childString.append(content)
    }
    
    override func assemble() {
        insertLevel()
        insertContent()
        assemble()
    }

    
    
}
