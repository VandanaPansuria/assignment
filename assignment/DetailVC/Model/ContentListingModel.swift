//
//  ContentListingModel.swift
//  assignment
//
//  Created by MacV on 06/06/22.
//

import Foundation
struct ContentListingModel: Codable {
    let page: pageModel
}
struct pageModel : Codable{
    let title: String
    let totalContentItems: String
    let pageNum: String
    let pageSize: String
    let ContentItems: contentItemModel
    enum CodingKeys: String, CodingKey {
        case title
        case totalContentItems = "total-content-items"
        case pageNum = "page-num"
        case pageSize = "page-size"
        case ContentItems = "content-items"
    }
}
struct contentItemModel : Codable{
    let content: [contentModel]
}
struct contentModel : Codable{
    let name: String
    let posterImage: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case posterImage = "poster-image"
       
    }
}
