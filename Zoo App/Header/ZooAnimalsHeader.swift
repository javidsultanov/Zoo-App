//
//  ZooAnimalsHeader.swift
//  Zoo App
//
//  Created by Javid Sultanov on 21.08.26.
//

import UIKit

class ZooAnimalsHeader: UICollectionReusableView {
    private lazy var animalImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var animalNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private lazy var animalSpeciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var animalsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ZooAnimalsHeaderCell.self, forCellWithReuseIdentifier: "ZooAnimalsHeaderCell")
        view.contentInset = UIEdgeInsets(top: 0,
                                         left: 8,
                                         bottom: 0,
                                         right: 8)
        view.backgroundColor = .black
        view.layer.cornerRadius = 12
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.bounces = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var animals: [Animal] = []
    
    private var selectedAnimalIndex = 0
    
    var animalCallback: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
    }
        
    private func configureConstraints() {
        addSubview(animalImageView)
        addSubview(animalNameLabel)
        addSubview(animalSpeciesLabel)
        addSubview(animalsCollectionView)
        
        NSLayoutConstraint.activate([
            animalImageView.topAnchor.constraint(equalTo: topAnchor),
            animalImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animalImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animalImageView.heightAnchor.constraint(equalToConstant: 300),
            
            animalNameLabel.bottomAnchor.constraint(equalTo: animalImageView.bottomAnchor, constant: -40),
            animalNameLabel.leadingAnchor.constraint(equalTo: animalImageView.leadingAnchor, constant: 12),
            
            animalSpeciesLabel.topAnchor.constraint(equalTo: animalNameLabel.bottomAnchor, constant: 4),
            animalSpeciesLabel.leadingAnchor.constraint(equalTo: animalNameLabel.leadingAnchor),
            
            animalsCollectionView.topAnchor.constraint(equalTo: animalImageView.bottomAnchor, constant: 8),
            animalsCollectionView.leadingAnchor.constraint(equalTo: animalImageView.leadingAnchor),
            animalsCollectionView.trailingAnchor.constraint(equalTo: animalImageView.trailingAnchor),
            animalsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configureHeader(animals: [Animal], selectedIndex: Int) {
        self.animals = animals
        selectedAnimalIndex = selectedIndex
        animalImageView.image = UIImage(named: animals[selectedAnimalIndex].animalImage)
        animalNameLabel.text = animals[selectedAnimalIndex].animalName
        animalSpeciesLabel.text = animals[selectedAnimalIndex].animalSpecies
        animalsCollectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZooAnimalsHeader: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooAnimalsHeaderCell", for: indexPath) as? ZooAnimalsHeaderCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(animal: animals[indexPath.item], selected: indexPath.item == selectedAnimalIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAnimalIndex = indexPath.item
        animalsCollectionView.reloadData()
        
        animalCallback?(indexPath.item)
    }
}

extension ZooAnimalsHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 64, height: 64)
    }
}
