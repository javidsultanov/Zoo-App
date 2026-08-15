//
//  OnboardingViewModel.swift
//  Zoo App
//
//  Created by Javid Sultanov on 13.08.26.
//

import Foundation

class OnboardingViewModel {
    private var onboardings: [Onboarding] = [.init(onboardingImage: "onboarding_zoos",
                                                   onboardingTitle: "Explore Our Zoos",
                                                   onboardingInfo: "Find interesting zoos from different places, learn more about each location, and discover the animals living in them. Plan your next wildlife adventure with ease."),
                                             .init(onboardingImage: "onboarding_animals",
                                                   onboardingTitle: "Meet Our Animals",
                                                   onboardingInfo: "Meet incredible animals and learn fascinating facts about their habitats, diets, behavior, and way of life. Discover something new about every animal you meet."),
                                             .init(onboardingImage: "onboarding_favorites",
                                                   onboardingTitle: "Save Your Favorites",
                                                   onboardingInfo: "Save the zoos and animals you love in your favorites, so you can quickly find and explore them again anytime. Keep all your favorite discoveries in one place.")]
    
    private var currentIndex = 0
    
    var nextCallback: (() -> Void)?
    var finishCallback: (() -> Void)?
    
    var numberOfPages: Int {
        onboardings.count
    }
    
    var currentPage: Int {
        currentIndex
    }
    
    var currentOnboarding: Onboarding {
        onboardings[currentIndex]
    }
    
    func nextPage() {
        if currentIndex == onboardings.count - 1 {
            completeOnboarding()
        } else {
            currentIndex += 1
            nextCallback?()
        }
    }
    
    func changePage(index: Int) {
        currentIndex = index
    }
    
    private func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        finishCallback?()
    }
}
