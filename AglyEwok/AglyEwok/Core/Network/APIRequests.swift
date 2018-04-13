//
//  APIManagerRequests.swift
//
//  Created by Yevhen Herasymenko.
//  Copyright © 2017 Stratege. All rights reserved.
//

import Alamofire

enum Header {

    private struct Key {
        static let token = "AuthenticateToken"
        static let permission = "Permission"
        static let permissionSignature = "PermissionSignature"
    }

    case noHeader

    func parse(header: [AnyHashable: Any]) {
        switch self {
        case .noHeader: break
        }
    }

    var header: [String: String]? {
        switch self {
        case .noHeader: return nil
        }
    }

}

fileprivate extension String {

    static func / (left: String, right: String) -> String {
        return left + "/" + right
    }

    static func /= (left: inout String, right: String) {
        left += "/" + right
    }

}

enum API {

    private struct Path {
        static let baseDiscord = "https://discordapp.com/api"
        static let baseTelegram = "https://api.telegram.org"

        static let webhooks = "webhooks"
        static let tokenDiscord = "2vY2CToKLpKJCjj_fQlS7m9c_eAdcpDXAPskuzA1zy1JmB2Scc1m1VxC37DIzoEV8hYN"
        static let identifier = "434330531841441793"

        static let tokenTelegramm = "bot562597999:AAGgSQJYmpgr9FsO-Gq-VI2tyoXw2PXBytE"
        static let sendMessage = "sendMessage"
    }

    static func sendDiscord(with message: String) -> Request<EmptyModel> {
        let url = Path.baseDiscord / Path.webhooks / Path.identifier / Path.tokenDiscord
        let parameters = ["content": message]
        return Request<EmptyModel>(method: .post,
                                   url: url,
                                   responseHeader: .noHeader,
                                   requestHeader: .noHeader,
                                   parameters: parameters)
    }

    static func sendTelegramm(with message: String) -> Request<EmptyModel> {
        let url = Path.baseTelegram / Path.tokenTelegramm / Path.sendMessage
        let parameters = ["chat_id": "@testbotfess",
                          "text": message]
        return Request<EmptyModel>(method: .post,
                                   url: url,
                                   responseHeader: .noHeader,
                                   requestHeader: .noHeader,
                                   parameters: parameters)
    }
}
