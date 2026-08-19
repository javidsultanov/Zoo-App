//
//  ZooCollectionGridCell.swift
//  Zoo App
//
//  Created by Javid Sultanov on 18.08.26.
//

import UIKit

class ZooGridCell: UICollectionViewCell {
    private lazy var zooImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        let configuration = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .medium)
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
        zooInfoButton.addTarget(self, action: #selector(zooInfoButtonTapped), for: .touchUpInside)
    }
        
    private func configureConstraints() {
        contentView.addSubview(zooImageView)
        contentView.addSubview(overlayView)
        contentView.addSubview(zooNameLabel)
        contentView.addSubview(zooCityLabel)
        contentView.addSubview(zooIDLabel)
        contentView.addSubview(zooInfoButton)
        
        NSLayoutConstraint.activate([
            zooImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            zooImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            zooImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            zooImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            overlayView.topAnchor.constraint(equalTo: zooImageView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: zooImageView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: zooImageView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: zooImageView.bottomAnchor),
            
            zooNameLabel.topAnchor.constraint(equalTo: zooImageView.topAnchor, constant: 8),
            zooNameLabel.leadingAnchor.constraint(equalTo: zooImageView.leadingAnchor, constant: 4),
            
            zooCityLabel.topAnchor.constraint(equalTo: zooNameLabel.bottomAnchor, constant: 8),
            zooCityLabel.leadingAnchor.constraint(equalTo: zooNameLabel.leadingAnchor),
            
            zooIDLabel.topAnchor.constraint(equalTo: zooCityLabel.bottomAnchor, constant: 8),
            zooIDLabel.leadingAnchor.constraint(equalTo: zooCityLabel.leadingAnchor),
            
            zooInfoButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            zooInfoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
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
