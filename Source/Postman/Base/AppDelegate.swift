//
//  AppDelegate.swift
//  Calatrava
//
//  Created by 郑宇琦 on 2018/1/18.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation
import PerfectHTTP
import Pjango
import Pjango_MySQL


class AppDelegate: PjangoDelegate {
    
    func setSettings() {
        
        // Pjango
        
        #if os(macOS)
            PJANGO_WORKSPACE_PATH = "/Users/enum/Developer/Postman/Workspace"
        #else
            PJANGO_WORKSPACE_PATH = "/home/uftp/Postman/Workspace"
        #endif
        
        
        PJANGO_LOG_DEBUG = false
        
        PJANGO_SERVER_PORT = 7999
        
        PJANGO_LOG_PATH = "runtime/postman.log"
        
        // Django
        
        PJANGO_BASE_DIR = ""
        
        PJANGO_TEMPLATES_DIR = "templates"
        
        PJANGO_STATIC_URL = "static"
        
    }
    
    func setUrls() -> [String: [PCUrlConfig]]? {
        
        return [
            
            PJANGO_HOST_DEFAULT: [
                pjangoUrl("curl", name: "curl", handle: getHandle),
            ]
        ]
    }
    
    func setDB() -> PCDataBase? {
        return MySQLDataBase.init(param: [
            "SCHEMA": "Pjango_Postman",
            "USER": "",
            "PASSWORD": "",
            "HOST": "127.0.0.1",
            "PORT": UInt16(3306),
            ])
    }
    
    func registerModels() -> [PCModel]? {
        return [
            PostmanConfigModel.meta,
            UserModel.meta,
            GetHistoryModel.meta,
        ]
    }
    
    func registerPlugins() -> [PCPlugin]? {
        return [
        ]
    }
    
}

