//
//  GetHistoryModel.swift
//  Postman
//
//  Created by 郑宇琦 on 2018/1/18.
//

import Foundation
import Pjango

class GetHistoryModel: PCModel {
    
    override var tableName: String {
        return "GetHistory"
    }
    
    var date = PCDataBaseField.init(name: "DATE", type: .string, length: 20)
    var user = PCDataBaseField.init(name: "USER", type: .string, length: 20)
    var key = PCDataBaseField.init(name: "KEY", type: .string, length: 64)
    var ip = PCDataBaseField.init(name: "IP", type: .string, length: 16)
    var port = PCDataBaseField.init(name: "PORT", type: .string, length: 6)
    var clientIp = PCDataBaseField.init(name: "CLIENT_IP", type: .string, length: 16)
    var clientPort = PCDataBaseField.init(name: "CLIENT_PORT", type: .string, length: 6)
    var url = PCDataBaseField.init(name: "URL", type: .string, length: 1024)
    var state = PCDataBaseField.init(name: "STATE", type: .string, length: 64)

    override func registerFields() -> [PCDataBaseField] {
        return [
            date, user, key, ip, port, clientIp, clientPort, url, state
        ]
    }
    
}
