// CollectionViewCell.swift
// Copyright © Boris. All rights reserved.

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    static var reuseID = "CollectionViewCell"

    // MARK: - private properties

    var onSelectedID: ((Int) -> Void)?
    var id: Int?

    private var serviceImage = ImageAPIService()

    // MARK: - Public properties

    lazy var posterImage = makePosterImage()
    lazy var titleLabel = makeTitleLabel()
    lazy var releaseLabel = makeReleaseLabel()
    lazy var popularityLabel = makePopularityLabel()
    lazy var popularityImage = makePopularityImage()
    lazy var overviewLebel = makeOverviewLebel()
    lazy var subView = makeSubView()

    // MARK: - Private properie

    private let imageERROR = "error"

    // MARK: - private functions

    private func convertDataFormatter(_ data: String?) -> String {
        var fixData = ""
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd"
        if let originalData = data {
            if let newData = dataFormatter.date(from: originalData) {
                dataFormatter.dateFormat = "dd.MM.yyyy"
                fixData = dataFormatter.string(from: newData)
            }
        }
        return fixData
    }

    // MARK: - public functions

    public func configurCell(movie: Movie) {
        popularityLabel.text = String(format: "%.1f", movie.voteAverage)
        overviewLebel.text = movie.overview
        titleLabel.text = movie.title
        releaseLabel.text = convertDataFormatter(movie.releaseDate)
    }

    func configCellImage(posterPath: String?) {
        serviceImage.updateImage(posterPath: posterPath) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(image):
                self.posterImage.image = image
            case let .failure(error):
                self.posterImage.image = UIImage(named: self.imageERROR)
                print(error.localizedDescription)
            }
        }
    }
}
