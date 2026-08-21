//
//  ZooAnimalsCell.swift
//  Zoo App
//
//  Created by Javid Sultanov on 21.08.26.
//

import UIKit

class ZooAnimalsCell: UICollectionViewCell {
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Animal Summary"
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var animalIDLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var animalAgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var animalDietLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var animalDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ticketPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        contentView.addSubview(summaryLabel)
        contentView.addSubview(animalIDLabel)
        contentView.addSubview(animalAgeLabel)
        contentView.addSubview(animalDietLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(animalDescriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(ticketPriceLabel)
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            animalIDLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 8),
            animalIDLabel.leadingAnchor.constraint(equalTo: summaryLabel.leadingAnchor),
            
            animalAgeLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 8),
            animalAgeLabel.leadingAnchor.constraint(equalTo: animalIDLabel.trailingAnchor, constant: 24),
            
            animalDietLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 8),
            animalDietLabel.leadingAnchor.constraint(equalTo: animalAgeLabel.trailingAnchor, constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: animalIDLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: animalIDLabel.leadingAnchor),
            
            animalDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            animalDescriptionLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            animalDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: animalDescriptionLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: animalDescriptionLabel.leadingAnchor),
            
            ticketPriceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            ticketPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor)
        ])
    }
    
    func configureCell(animal: Animal, ticketPrice: String) {
        animalIDLabel.text = "ID\n\(animal.animalID)"
        animalAgeLabel.text = "Age\n\(animal.animalAge)"
        animalDietLabel.text = "Diet\n\(animal.animalDiet.rawValue)"
        animalDescriptionLabel.text = animal.animalDescription
        ticketPriceLabel.text = ticketPrice
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
