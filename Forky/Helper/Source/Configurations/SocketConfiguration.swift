//
//  File.swift
//  
//
//  Created by Prakhar Pandey on 06/07/22.
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
