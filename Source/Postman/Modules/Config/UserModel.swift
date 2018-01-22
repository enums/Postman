//
//  UserModel.swift
//  Postman
//
//  Created by 郑宇琦 on 2018/1/19.
//

import Foundation
import Pjango

class UserModel: PCModel {
    
    override var tableName: String {
        return "User"
    }
    
    var key = PCDataBaseField.init(name: "KEY", type: .string, length: 64)
    var name = PCDataBaseField.init(name: "NAME", type: .string, length: 20)
    var memo = PCDataBaseField.init(name: "MEMO", type: .string, length: 128)
    
    override func registerFields() -> [PCDataBaseField] {
        return [
            key, name, memo
        ]
    }
    
}
