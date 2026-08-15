//
//  OnboardingCell.swift
//  Zoo App
//
//  Created by Javid Sultanov on 14.08.26.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
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
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        contentView.backgroundColor = .systemGreen
    }
    
    private func configureConstraints() {
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(onboardingImageView)
        contentView.addSubview(bottomView)
        
        bottomView.addSubview(onboardingTitleLabel)
        bottomView.addSubview(onboardingInfoLabel)
        
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 44),
            mainTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.88),
            
            onboardingImageView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 20),
            onboardingImageView.leadingAnchor.constraint(equalTo: mainTitleLabel.leadingAnchor),
            onboardingImageView.trailingAnchor.constraint(equalTo: mainTitleLabel.trailingAnchor),
            onboardingImageView.heightAnchor.constraint(equalToConstant: 360),
            
            bottomView.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 20),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            onboardingTitleLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 28),
            onboardingTitleLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 32),
            onboardingTitleLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -32),
            
            onboardingInfoLabel.topAnchor.constraint(equalTo: onboardingTitleLabel.bottomAnchor, constant: 16),
            onboardingInfoLabel.leadingAnchor.constraint(equalTo: onboardingTitleLabel.leadingAnchor),
            onboardingInfoLabel.trailingAnchor.constraint(equalTo: onboardingTitleLabel.trailingAnchor)
        ])
    }
    
    func configureCell(onboarding: Onboarding) {
        onboardingImageView.image = UIImage(named: onboarding.onboardingImage)
        onboardingTitleLabel.text = onboarding.onboardingTitle
        onboardingInfoLabel.text = onboarding.onboardingInfo
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
