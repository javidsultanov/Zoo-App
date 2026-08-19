//
//  ZooCollectionListCell.swift
//  Zoo App
//
//  Created by Javid Sultanov on 18.08.26.
//

import UIKit

class ZooListCell: UICollectionViewCell {
    private lazy var zooImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var zooNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var zooCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var zooIDLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var zooInfoButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .medium)
        let image = UIImage(systemName: "info.circle.fill", withConfiguration: configuration)
        
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var zooInfoButtonActionCallback: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 12
        
        zooInfoButton.addTarget(self, action: #selector(zooInfoButtonTapped), for: .touchUpInside)
    }
        
    private func configureConstraints() {
        contentView.addSubview(zooImageView)
        contentView.addSubview(zooNameLabel)
        contentView.addSubview(zooCityLabel)
        contentView.addSubview(zooIDLabel)
        contentView.addSubview(zooInfoButton)
        
        NSLayoutConstraint.activate([
            zooImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            zooImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            zooImageView.widthAnchor.constraint(equalToConstant: 100),
            zooImageView.heightAnchor.constraint(equalToConstant: 100),
            
            zooNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            zooNameLabel.leadingAnchor.constraint(equalTo: zooImageView.trailingAnchor, constant: 12),
            
            zooCityLabel.topAnchor.constraint(equalTo: zooNameLabel.bottomAnchor, constant: 12),
            zooCityLabel.leadingAnchor.constraint(equalTo: zooNameLabel.leadingAnchor),
            
            zooIDLabel.topAnchor.constraint(equalTo: zooCityLabel.bottomAnchor, constant: 12),
            zooIDLabel.leadingAnchor.constraint(equalTo: zooNameLabel.leadingAnchor),
            
            zooInfoButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            zooInfoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    func configureCell(zoo: Zoo) {
        zooImageView.image = UIImage(named: zoo.zooImage)
        zooNameLabel.text = zoo.zooName
        zooCityLabel.text = zoo.zooCity
        zooIDLabel.text = "\(zoo.zooID)"
    }
    
    @objc private func zooInfoButtonTapped() {
        zooInfoButtonActionCallback?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
