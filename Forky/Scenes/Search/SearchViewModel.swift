//
//  SearchViewModel.swift
//  Forky
//
//  Created by Vivek Patel on 26/12/22.
//

import Foundation

class SearchViewModel: NSObject {
    var data:SearchSectionModel = SearchSectionModel()
}

struct SearchSectionModel:Decodable
{
    var section:[TypeSection] = [.search, .nearby]
    
    enum TypeSection: String,Decodable{
        case search
        case nearby
    }
}
