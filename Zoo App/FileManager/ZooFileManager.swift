//
//  ZooFileManager.swift
//  Zoo App
//
//  Created by Javid Sultanov on 18.08.26.
//

import Foundation

class ZooFileManager {
    var zoos: [Zoo] = []
    
    func getZooItems() {
        guard let url = Bundle.main.url(forResource: "Zoo", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            zoos = try JSONDecoder().decode([Zoo].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
