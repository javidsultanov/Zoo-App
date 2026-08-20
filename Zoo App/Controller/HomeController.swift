//
//  HomeController.swift
//  Zoo App
//
//  Created by Javid Sultanov on 14.08.26.
//

import UIKit

class HomeController: UIViewController {
    private lazy var zooCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemGreen
        view.register(ZooListCell.self, forCellWithReuseIdentifier: "ZooListCell")
        view.register(ZooGridCell.self, forCellWithReuseIdentifier: "ZooGridCell")
        view.isHidden = false
        view.delegate = self
        view.dataSource = self
        view.bounces = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var toggleButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(toggleButtonTapped))
        return button
    }()
    
    private var currentMode: ViewMode = .list
    
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
        configureViewModel()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGreen
        navigationItem.title = "SAS Zoo"
        
        navigationItem.rightBarButtonItem = toggleButton
    }
    
    private func configureConstraints() {
        view.addSubview(zooCollectionView)
        
        NSLayoutConstraint.activate([
            zooCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            zooCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zooCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
            zooCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
    private func configureViewModel() {
        viewModel.fetchZoos()
        zooCollectionView.reloadData()
    }
    
    @objc private func toggleButtonTapped() {
        switch currentMode {
        case .grid:
            currentMode = .list
            toggleButton.image = UIImage(systemName: "square.grid.2x2")
            
        case .list:
            currentMode = .grid
            toggleButton.image = UIImage(systemName: "list.bullet")
        }
        
        zooCollectionView.collectionViewLayout.invalidateLayout()
        zooCollectionView.reloadData()
    }
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.zoos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch currentMode {
        case .list:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooListCell", for: indexPath) as? ZooListCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(zoo: viewModel.zoos[indexPath.item])
            cell.zooInfoButtonActionCallback = {
                self.showDefaultAlert(title: self.viewModel.zoos[indexPath.item].zooName,
                                      message: self.viewModel.zoos[indexPath.item].zooInfo)
            }
            return cell
            
        case .grid:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooGridCell", for: indexPath) as? ZooGridCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(zoo: viewModel.zoos[indexPath.item])
            cell.zooInfoButtonActionCallback = {
                self.showDefaultAlert(title: self.viewModel.zoos[indexPath.item].zooName,
                                      message: self.viewModel.zoos[indexPath.item].zooInfo)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = ZooAnimalsController()
        controller.zoo = viewModel.zoos[indexPath.item]
        controller.title = viewModel.zoos[indexPath.item].zooName
        controller.hidesBottomBarWhenPushed = true
        navigationController?.show(controller, sender: self)
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let containerWidth = zooCollectionView.frame.width
        
        switch currentMode {
        case .grid:
            let width = (containerWidth - 12) / 2
            return .init(width: width, height: width)
            
        case .list:
            return .init(width: containerWidth, height: 112)
        }
    }
}
