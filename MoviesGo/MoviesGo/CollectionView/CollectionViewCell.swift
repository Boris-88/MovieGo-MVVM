// CollectionViewCell.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    static var reuseID = "CollectionViewCell"

    // MARK: - private properties

    var onSelectedID: ((Int) -> Void)?
    var id: Int?

    private var networkLayer = NetWorcLayer()

    // MARK: - Public properties

    lazy var posterImage = makePosterImage()
    lazy var titleLabel = makeTitleLabel()
    lazy var releaseLabel = makeReleaseLabel()
    lazy var popularityLabel = makePopularityLabel()
    lazy var popularityImage = makePopularityImage()
    lazy var overviewLebel = makeOverviewLebel()
    lazy var subView = makeSubView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

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

    public func update(mainHost: String, posterPath: String?) {
        if let posterPath = posterPath, let url = URL(string: mainHost + posterPath) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if error != nil {
                    DispatchQueue.main.async { [weak self] in
                        self?.posterImage.image = UIImage(named: "error")
                    }
                } else if let data = data {
                    DispatchQueue.main.async { [weak self] in
                        self?.posterImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
