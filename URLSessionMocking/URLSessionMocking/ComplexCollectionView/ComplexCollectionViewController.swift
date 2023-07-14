//
//  ComplexCollectionViewController.swift
//  URLSessionMocking
//
//  Created by Harish on 12/07/23.
//

import UIKit

class ComplexCollectionViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setupCollectionViewLayout()
    }
    
    func setupConstraints() {
        self.contentView.addSubview(collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.collectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.layer.borderColor = UIColor.blue.cgColor
        collection.layer.borderWidth = 3
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: FirstSectionCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: FirstSectionCell.identifier)
        collection.register(UINib(nibName: SecondSectionCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: SecondSectionCell.identifier)
        collection.register(UINib(nibName: ThirdSectionCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: ThirdSectionCell.identifier)
        return collection
    }()

    func setupCollectionViewLayout() {
        
        let collectionViewCompositionalLayout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0:
                return self.firstSectionLayout()
            case 1:
                return self.secondSectionLayout()
            default:
                return self.thirdSectionLayout()
            }
        }
        
        collectionView.setCollectionViewLayout(collectionViewCompositionalLayout, animated: true)
    }
    
    func firstSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func secondSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.15))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func thirdSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
}

extension ComplexCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 8
        case 1:
            return 5
        default:
            return 10
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let firstSectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstSectionCell.identifier, for: indexPath)
            return firstSectionCell
        case 1:
            let secondSectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondSectionCell.identifier, for: indexPath)
            return secondSectionCell
        default:
            let thirdSectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThirdSectionCell.identifier, for: indexPath)
            return thirdSectionCell
        }
    }
}
