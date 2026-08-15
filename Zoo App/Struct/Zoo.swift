//
//  Zoo.swift
//  Zoo App
//
//  Created by Javid Sultanov on 15.08.26.
//

import Foundation

struct Zoo: Codable {
    var zooImage: String
    var zooName: String
    var zooCity: String
    var zooInfo: String
    var zooAnimals: [Animal]
}

struct Animal: Codable {
    var animalImage: String
    var animalID: Int
    var animalName: String
    var animalSpecies: String
    var animalAge: Int
    var animalDiet: DietType
    var animalDescription: String
}

enum DietType: String, Codable {
    case carnivore = "Carnivore (Meat-Eaters)"
    case herbivore = "Herbivore (Plant-Eaters)"
    case omnivore = "Omnivore (Meat and Plant Eaters)"
}
