//
//  SavedSectionModel.swift
//  Forky
//
//  Created by Vivek Sadariya on 05/01/22.
//

import Foundation

struct SavedSectionModel:Decodable
{
    var section:[TypeSection] = [.search, .postGrid]
    
    enum TypeSection: String,Decodable{
        case search
        case postGrid
    }
}
