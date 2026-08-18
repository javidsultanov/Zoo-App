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
        view.isHidden = false
        view.delegate = self
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

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .secondarySystemBackground
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
    
    @objc private func toggleButtonTapped() {
        switch currentMode {
        case .grid:
            currentMode = .list
            toggleButton.image = UIImage(systemName: "square.grid.2x2")
        case .list:
            currentMode = .grid
            toggleButton.image = UIImage(systemName: "list.bullet")
        }
        
        zooCollectionView.performBatchUpdates(zooCollectionView.collectionViewLayout.invalidateLayout,
                                              completion: nil)
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
            return .init(width: containerWidth, height: 80)
        }
    }
}
