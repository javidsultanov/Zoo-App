//
//  OnboardingController.swift
//  Zoo App
//
//  Created by Javid Sultanov on 13.08.26.
//

import UIKit

//MARK: Onboarding View

class OnboardingController: UIViewController {
    private lazy var onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = false
        return view
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
    
    //MARK: View Functions
    
    private func configureUI() {
        view.backgroundColor = .systemGreen
        
        onboardingButton.addTarget(self, action: #selector(onBoardingButtonTapped), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        view.addSubview(onboardingCollectionView)
        view.addSubview(onboardingButton)
        view.addSubview(pagecontrol)
        
        NSLayoutConstraint.activate([
            onboardingCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            onboardingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pagecontrol.leadingAnchor.constraint(equalTo: onboardingCollectionView.leadingAnchor, constant: 24),
            pagecontrol.bottomAnchor.constraint(equalTo: onboardingCollectionView.bottomAnchor, constant: -76),
            
            onboardingButton.trailingAnchor.constraint(equalTo: onboardingCollectionView.trailingAnchor, constant: -24),
            onboardingButton.bottomAnchor.constraint(equalTo: onboardingCollectionView.bottomAnchor, constant: -64),
            onboardingButton.widthAnchor.constraint(equalToConstant: 96),
            onboardingButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    private func configureViewModel() {
        pagecontrol.numberOfPages = viewModel.onboardings.count
        
        viewModel.nextCallback = {
            self.configureOnboarding()
        }
        
        viewModel.finishCallback = {
            self.showHomePage()
        }
        
        onboardingCollectionView.reloadData()
        view.layoutIfNeeded()
        configureOnboarding()
    }
    
    private func configureOnboarding() {
        pagecontrol.currentPage = viewModel.currentIndex
                
        onboardingCollectionView.scrollToItem(at: IndexPath(item: viewModel.currentIndex, section: 0),
                                              at: .centeredHorizontally,
                                              animated: true)
        
        if viewModel.currentIndex == viewModel.onboardings.count - 1 {
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

//MARK: Onboarding View DataSource

extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.onboardings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(onboarding: viewModel.onboardings[indexPath.item])
        return cell
    }
    
}

//MARK: Onboarding View FlowLayout

extension OnboardingController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

//MARK: Onboarding Scroll Delegate

extension OnboardingController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        viewModel.currentIndex = width
        configureOnboarding()
    }
}
