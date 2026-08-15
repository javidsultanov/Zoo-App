//
//  HomeController.swift
//  Zoo App
//
//  Created by Javid Sultanov on 14.08.26.
//

import UIKit

class HomeController: UIViewController {
    private lazy var zooTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var zooCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var toggleButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "list.bullet"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(toggleButtonTapped))
        return button
    }()

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
        view.addSubview(zooTableView)
        view.addSubview(zooCollectionView)
        
        NSLayoutConstraint.activate([
            zooTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            zooTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zooTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
            zooTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            zooCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            zooCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zooCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
            zooCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func toggleButtonTapped() {
        if zooTableView.isHidden {
            zooTableView.isHidden = false
            zooCollectionView.isHidden = true
            toggleButton.image = UIImage(systemName: "square.grid.2x2")
        } else {
            zooTableView.isHidden = true
            zooCollectionView.isHidden = false
            toggleButton.image = UIImage(systemName: "list.bullet")
        }
    }
}
