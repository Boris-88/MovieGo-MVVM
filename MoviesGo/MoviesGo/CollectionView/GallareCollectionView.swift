// GallareCollectionView.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class GallareCollectionView: UICollectionView {
    // MARK: - Stored Properties

    var pageDataMovie: PageDataMovie? {
        didSet {
            reloadData()
        }
    }

    var onSelectedID: ((Int) -> Void)?

    // MARK: - PRIVATE PROPERTY

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .black
        delegate = self
        dataSource = self
        register(GallaryCollectionViewCell.self, forCellWithReuseIdentifier: GallaryCollectionViewCell.reuseID)
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 10
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate

extension GallareCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = pageDataMovie?.movies[indexPath.row].id else {
            return
        }
        onSelectedID?(id)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        cell.alpha = 0.2
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? GallaryCollectionViewCell {
                cell.transform = .init(scaleX: 0.85, y: 0.85)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? GallaryCollectionViewCell {
                cell.transform = .identity
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension GallareCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageDataMovie?.movies.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: GallaryCollectionViewCell.reuseID,
            for: indexPath
        ) as? GallaryCollectionViewCell else { return UICollectionViewCell() }
        if let pageDataMovie = pageDataMovie {
            let movie = pageDataMovie.movies[indexPath.row]
            cell.update(mainHost: AppSetting.imageHost, posterPath: movie.posterPath)
            cell.titleData = movie.title
            cell.overviewData = movie.overview
            cell.popularyData = movie.popularity
            cell.releaseData = movie.releaseDate
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GallareCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 400, height: 200)
    }
}
