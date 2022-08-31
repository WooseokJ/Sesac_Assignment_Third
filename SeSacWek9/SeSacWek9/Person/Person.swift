//
//  Person.swift
//  SeSacWek9
//
//  Created by useok on 2022/08/30.
//

import Foundation

struct Person: Codable {
    let page, totalPages, totalResults: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Result: Codable {
    let knwonForDepartment, name: String
    enum CodingKeys: String, CodingKey {
        case knwonForDepartment = "known_for_department" //json 응답값으로오는게 snake case(_)로 와서
        case name
        
    }
}
