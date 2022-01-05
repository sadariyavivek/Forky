//
//  ExploreSectionModel.swift
//  Forky
//
//  Created by Vivek Sadariya on 09/10/21.
//

import Foundation


struct AccSectionModel:Decodable
{
    var section:[TypeSection] = [.carousel, .search, .experience, .nearbyFlt, .nearby]
    
    enum TypeSection: String,Decodable{
        case carousel
        case search
        case experience
        case nearby
        case nearbyFlt
    }
}
