//
//  OnboardingViewModel.swift
//  Zoo App
//
//  Created by Javid Sultanov on 13.08.26.
//

import Foundation

class OnboardingViewModel {
    private var onboardings: [Onboarding] = [.init(onboardingImage: "onboarding_zoos",
                                                   onboardingTitle: "Explore Zoos!",
                                                   onboardingInfo: "Find interesting zoos and discover the animals living in them."),
                                             .init(onboardingImage: "onboarding_animals",
                                                   onboardingTitle: "Meet Animals!",
                                                   onboardingInfo: "Learn fascinating facts about animals, their habitats and diets."),
                                             .init(onboardingImage: "onboarding_favorites",
                                                   onboardingTitle: "Save Favorites!",
                                                   onboardingInfo: "Save your favorite zoos and animals to find them again anytime.")]
    
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
    
    private func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        finishCallback?()
    }
}
