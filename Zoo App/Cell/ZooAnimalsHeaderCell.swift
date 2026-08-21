//
//  ZooAnimalsHeaderCell.swift
//  Zoo App
//
//  Created by Javid Sultanov on 21.08.26.
//

import UIKit

class ZooAnimalsHeaderCell: UICollectionViewCell {
    private lazy var animalImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
    }
        
    private func configureConstraints() {
        contentView.addSubview(animalImageView)
        
        NSLayoutConstraint.activate([
            animalImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            animalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            animalImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            animalImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureCell(animal: Animal, selected: Bool) {
        animalImageView.image = UIImage(named: animal.animalImage)

        if selected {
            contentView.layer.borderWidth = 3
            contentView.layer.cornerRadius = 12
            contentView.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            contentView.layer.borderWidth = 0
            contentView.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
