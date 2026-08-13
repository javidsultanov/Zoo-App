//
//  OnboardingController.swift
//  Zoo App
//
//  Created by Javid Sultanov on 13.08.26.
//

import UIKit

class OnboardingController: UIViewController {
    private lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover the World of Wildlife"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 36
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var onboardingImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var onboardingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var onboardingInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var onboardingButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var pagecontrol: UIPageControl = {
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = .systemGreen
        page.pageIndicatorTintColor = .systemGray
        page.isUserInteractionEnabled = false
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()
    
    private let viewModel = OnboardingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        configureViewModel()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGreen
        
        onboardingButton.addTarget(self, action: #selector(onBoardingButtonTapped), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        view.addSubview(mainTitleLabel)
        view.addSubview(onboardingImageView)
        view.addSubview(bottomView)
        
        bottomView.addSubview(onboardingTitleLabel)
        bottomView.addSubview(onboardingInfoLabel)
        bottomView.addSubview(pagecontrol)
        bottomView.addSubview(onboardingButton)
        
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            mainTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88),
            
            onboardingImageView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 20),
            onboardingImageView.leadingAnchor.constraint(equalTo: mainTitleLabel.leadingAnchor),
            onboardingImageView.trailingAnchor.constraint(equalTo: mainTitleLabel.trailingAnchor),
            onboardingImageView.heightAnchor.constraint(equalToConstant: 360),
            
            bottomView.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 20),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            onboardingTitleLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 28),
            onboardingTitleLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 32),
            onboardingTitleLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -32),
            
            onboardingInfoLabel.topAnchor.constraint(equalTo: onboardingTitleLabel.bottomAnchor, constant: 16),
            onboardingInfoLabel.leadingAnchor.constraint(equalTo: onboardingTitleLabel.leadingAnchor),
            onboardingInfoLabel.trailingAnchor.constraint(equalTo: onboardingTitleLabel.trailingAnchor),
            
            pagecontrol.leadingAnchor.constraint(equalTo: onboardingInfoLabel.leadingAnchor),
            pagecontrol.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -76),
            
            onboardingButton.trailingAnchor.constraint(equalTo: onboardingInfoLabel.trailingAnchor),
            onboardingButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -64),
            onboardingButton.widthAnchor.constraint(equalToConstant: 96),
            onboardingButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    private func configureViewModel() {
        pagecontrol.numberOfPages = viewModel.numberOfPages
        
        viewModel.nextCallback = {
            self.configureOnboarding()
        }
        
        viewModel.finishCallback = {
            self.showHomePage()
        }
        
        configureOnboarding()
    }
    
    private func configureOnboarding() {
        let onboarding = viewModel.currentOnboarding
        
        onboardingImageView.image = UIImage(named: onboarding.onboardingImage)
        onboardingTitleLabel.text = onboarding.onboardingTitle
        onboardingInfoLabel.text = onboarding.onboardingInfo
        
        pagecontrol.currentPage = viewModel.currentPage
        
        if viewModel.currentPage == viewModel.numberOfPages - 1 {
            onboardingButton.setTitle("Let's Start", for: .normal)
        } else {
            onboardingButton.setTitle("Next", for: .normal)
        }
    }
    
    @objc private func onBoardingButtonTapped() {
        viewModel.nextPage()
    }
    
    private func showHomePage() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            sceneDelegate.setHomeAsRoot()
        }
    }
}
