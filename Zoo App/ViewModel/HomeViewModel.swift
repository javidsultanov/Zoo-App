//
//  HomeViewModel.swift
//  Zoo App
//
//  Created by Javid Sultanov on 18.08.26.
//

import Foundation

class HomeViewModel {
    var zoos: [Zoo] = []
    
    private let manager = ZooFileManager()
    
    func fetchZoos() {
        zoos = manager.zoos
        manager.getZooItems()
    }
}
