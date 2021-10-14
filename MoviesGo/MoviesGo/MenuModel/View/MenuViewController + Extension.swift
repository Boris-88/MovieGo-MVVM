// MenuViewController + Extension.swift
// Copyright © Boris. All rights reserved.

import UIKit

extension MenuViewController {
    func makeCollectionView() -> UICollectionView {
        let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .vertical
        layot.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            CollectionViewCell.self,
            forCellWithReuseIdentifier: CollectionViewCell.reuseID
        )
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        return collectionView
    }

    func makeActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .darkGray
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        return activityIndicator
    }
}
