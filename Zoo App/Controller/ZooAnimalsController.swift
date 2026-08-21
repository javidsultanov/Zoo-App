//
//  ZooAnimalsController.swift
//  Zoo App
//
//  Created by Javid Sultanov on 21.08.26.
//

import UIKit

class ZooAnimalsController: UIViewController {
    private lazy var animalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ZooAnimalsCell.self, forCellWithReuseIdentifier: "ZooAnimalsCell")
        view.register(ZooAnimalsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ZooAnimalsHeader")
        view.backgroundColor = .systemGreen
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.bounces = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var selectedAnimalIndex = 0
    
    var zoo: Zoo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGreen
    }
    
    private func configureConstraints() {
        view.addSubview(animalCollectionView)
        
        NSLayoutConstraint.activate([
            animalCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            animalCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animalCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
            animalCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ZooAnimalsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if zoo?.zooAnimals.isEmpty == false {
            return 1
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooAnimalsCell", for: indexPath) as? ZooAnimalsCell else {
            return UICollectionViewCell()
        }
        
        guard let animals = zoo?.zooAnimals else {
            return cell
        }
        
        guard let zoo = zoo else {
            return cell
        }
        
        cell.configureCell(animal: animals[selectedAnimalIndex], ticketPrice: zoo.zooTicketPrice)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ZooAnimalsHeader", for: indexPath) as? ZooAnimalsHeader else {
            return UICollectionViewCell()
        }
        
        guard let animals = zoo?.zooAnimals else {
            return header
        }
        
        header.configureHeader(animals: animals, selectedIndex: selectedAnimalIndex)
        header.animalCallback = { selectedIndex in
            self.selectedAnimalIndex = selectedIndex
            self.animalCollectionView.reloadData()
        }
        
        return header
    }
}

extension ZooAnimalsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return .init(width: width, height: 440)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return .init(width: width, height: 400)
    }
}
