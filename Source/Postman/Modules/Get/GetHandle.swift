//
//  GetHandle.swift
//  Postman
//
//  Created by 郑宇琦 on 2018/1/18.
//

import Foundation
import PerfectHTTP
import PerfectCURL
import Pjango
import SwiftyJSON

func getHandle() -> PCUrlHandle {
    
    return pjangoHttpResponse { req, res in
        let ip = req.remoteAddress.host
        let port = "\(req.remoteAddress.port)"
        let model = GetHistoryModel.init()
        model.date.strValue = Date.init().stringValue
        model.user.strValue = ""
        model.key.strValue = ""
        model.ip.strValue = ip
        model.port.strValue = port
        model.clientIp.strValue = ""
        model.clientPort.strValue = ""
        model.url.strValue = ""
        model.state.strValue = "INIT"
        defer {
            GetHistoryModel.insertObject(model)
        }
        logger.info("[\(ip)][\(port)] Receive request.")
        guard let postBytes = req.postBodyBytes, let bodyDecrypted = PostmanEncryptor.decode(bytes: postBytes) else {
            model.state.strValue = "DECRYPT FAILED"
            logger.error("[\(ip)][\(port)] Decrypt failed!")
            pjangoHttpResponse("")(req, res)
            return
        }
        let json = JSON.parse(bodyDecrypted)
        guard json != JSON.null else {
            model.state.strValue = "PARSE FAILED"
            logger.error("[\(ip)][\(port)] Parser failed!")
            pjangoHttpResponse("")(req, res)
            return
        }
        guard let key = json["key"].string else {
            model.state.strValue = "KEY IS NIL"
            logger.error("[\(ip)][\(port)] Kye is nil!")
            pjangoHttpResponse("")(req, res)
            return
        }
        model.key.strValue = key
        guard let user = ((UserModel.queryObjects() as? [UserModel])?.filter { $0.key.strValue == key })?.first else {
            model.state.strValue = "USER ILLEGAL"
            logger.error("[\(ip)][\(port)] User illeagl!")
            pjangoHttpResponse("")(req, res)
            return
        }
        model.user.strValue = user.name.strValue
        guard let url = json["url"].string else {
            model.state.strValue = "URL IS NIL"
            logger.error("[\(ip)][\(port)] Url is nil!")
            pjangoHttpResponse("")(req, res)
            return
        }
        model.url.strValue = url
        guard let clientIp = json["client_ip"].string else {
            model.state.strValue = "CLIENT IP IS NIL"
            logger.error("[\(ip)][\(port)] Client ip is nil!")
            pjangoHttpResponse("")(req, res)
            return
        }
        model.clientIp.strValue = clientIp
        guard let clientPort = json["client_port"].string else {
            model.state.strValue = "CLIENT PORT IS NIL"
            logger.error("[\(ip)][\(port)] Client port is nil!")
            pjangoHttpResponse("")(req, res)
            return
        }
        model.clientPort.strValue = clientPort
        
        let curl = CURL.init(url: url)
        let (_, _, body) = curl.performFully()
        model.state.strValue = "SUCCESS"
        logger.info("[\(ip)][\(port)] Success! URL: \(url)")
        
        pjangoHttpResponse(PostmanEncryptor.encode(bytes: body) ?? [])(req, res)
    }
    
}


