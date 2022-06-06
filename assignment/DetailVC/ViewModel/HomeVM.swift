//
//  HomeVM.swift
//  assignment
//
//  Created by MacV on 06/06/22.
//

import Foundation
import UIKit
class HomeVM{
    internal var comedyList: [contentModel] = []
    internal var filteredList: Dynamic<[contentModel]> = Dynamic([])
    internal var pageTitle : String = ""
     func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let parseData = try JSONDecoder().decode(HomeModel.self,
                                                           from: jsonData)
                pageTitle = parseData.page.title
                comedyList = parseData.page.ContentItems.content
                self.filteredList.value = comedyList
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}

//MARK:- search filter
extension HomeVM {
    
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
