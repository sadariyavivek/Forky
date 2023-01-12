//
//  File.swift
//  
//
//  //  Created by Vivek Patel on 12/01/23.
//

enum Emitter: String {
    case subscribe
    case unsubscribe
}

/// Configuration for socket subscribe and listen
public enum SocketConfiguration: Configuration {
    case subscribeAndListen(_ topic: String)
    case unsubscribe(_ topics: [String])
    case disconnect
}
