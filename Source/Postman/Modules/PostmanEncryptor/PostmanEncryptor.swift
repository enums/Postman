//
//  PostmanEncryptor.swift
//  Postman
//
//  Created by 郑宇琦 on 2018/1/18.
//

import Foundation
import PerfectCrypto

class PostmanEncryptor {
    
    static fileprivate let cipher = Cipher.aes_256_cbc
    static fileprivate let key = [UInt8](PostmanConfigModel.eKey.data(using: .utf8)!)
    static fileprivate let iv = [UInt8](PostmanConfigModel.eIv.data(using: .utf8)!)

    static func encode(str: String) -> [UInt8]? {
        return encode(bytes: Array(str.utf8))
    }
    
    static func encode(bytes: [UInt8]) -> [UInt8]? {
        guard let encoded = bytes.encrypt(cipher, key: key, iv: iv) else {
            return nil
        }
        return encoded
    }
    
    static func decode(bytes: [UInt8]) -> String? {
        guard let decoded = bytes.decrypt(cipher, key: key, iv: iv) else {
            return nil
        }
        return String(validatingUTF8: decoded)
    }
    
}
