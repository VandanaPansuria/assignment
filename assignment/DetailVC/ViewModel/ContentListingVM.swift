//
//  ContentListingVM.swift
//  assignment
//
//  Created by MacV on 06/06/22.
//

import Foundation
import UIKit
class ContentListingVM{
    internal var comedyList: [contentModel] = []
    internal var filteredList: Dynamic<[contentModel]> = Dynamic([])
    internal var pageTitle : String = ""
    func readLocalFile(forName name: String,completion: @escaping (([contentModel])) -> ()) {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let parseData = try JSONDecoder().decode(ContentListingModel.self,
                                                           from: jsonData)
                pageTitle = parseData.page.title
                comedyList.append(contentsOf: parseData.page.ContentItems.content)
                self.filteredList.value.append(contentsOf: parseData.page.ContentItems.content)
                completion(comedyList)
            }else{
                completion([])
            }
        } catch {
            print(error)
        }
    }
}

//MARK:- search filter
extension ContentListingVM {
    
    func clearSearch() {
        self.filteredList.value = comedyList
    }
    func searchFor(_ keyword: String) {
        filteredList.value = comedyList.filter({$0.name.localizedCaseInsensitiveContains(keyword)})
        if keyword.count == 0{
            filteredList.value = comedyList
        }
    }
}
