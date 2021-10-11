// ReleaseTableViewCell.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class ReleaseTableViewCell: UITableViewCell {
    static var reuseID = "ReleaseTableViewCell"

    var releaseDate: String? {
        didSet { releaseDateLabel.text = convertDataFormatter(releaseDate) }
    }

    var popularyMovie: Double? {
        didSet { popularityLabel.text = String(format: "%.1f", popularyMovie ?? 00) }
    }

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.contentMode = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let releaseDatePresentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.contentMode = .top
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "Дата релиза:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let popularityPresentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.contentMode = .top
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "Рейтинг:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.contentMode = .top
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let popularityImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "asterisk")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        addSubview(releaseDateLabel)
        addSubview(releaseDatePresentLabel)
        addSubview(popularityLabel)
        addSubview(popularityPresentLabel)
        addSubview(popularityImage)
        createConstrainReleaseDateLabel()
        createConstrainReleaseDatePresentLabel()
        createConstrainPopularityLabel()
        createConstrainPopularityPresentLabel()
        createPopularityImageView()
    }

    private func createConstrainReleaseDateLabel() {
        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: releaseDatePresentLabel.bottomAnchor, constant: 3),
            releaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: popularityLabel.leadingAnchor),
            releaseDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 30),
            releaseDateLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func createConstrainReleaseDatePresentLabel() {
        NSLayoutConstraint.activate([
            releaseDatePresentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            releaseDatePresentLabel.topAnchor.constraint(equalTo: topAnchor),
            releaseDatePresentLabel.heightAnchor.constraint(equalToConstant: 30),
            releaseDatePresentLabel.widthAnchor.constraint(equalToConstant: 140)
        ])
    }

    private func createConstrainPopularityLabel() {
        NSLayoutConstraint.activate([
            popularityLabel.topAnchor.constraint(equalTo: popularityPresentLabel.bottomAnchor, constant: 3),
            popularityLabel.leadingAnchor.constraint(equalTo: releaseDateLabel.trailingAnchor, constant: 100),
            popularityLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            popularityLabel.heightAnchor.constraint(equalToConstant: 30),
            popularityLabel.widthAnchor.constraint(equalToConstant: 50)

        ])
    }

    private func createConstrainPopularityPresentLabel() {
        NSLayoutConstraint.activate([
            popularityPresentLabel.leadingAnchor.constraint(
                equalTo: releaseDatePresentLabel.trailingAnchor,
                constant: 50
            ),
            popularityPresentLabel.topAnchor.constraint(equalTo: topAnchor),
            popularityPresentLabel.trailingAnchor.constraint(equalTo: popularityImage.leadingAnchor, constant: 10),
            popularityPresentLabel.heightAnchor.constraint(equalToConstant: 30),
            popularityPresentLabel.widthAnchor.constraint(equalToConstant: 140)
        ])
    }

    private func createPopularityImageView() {
        NSLayoutConstraint.activate([
            popularityImage.topAnchor.constraint(equalTo: popularityPresentLabel.bottomAnchor, constant: 3),
            popularityImage.leadingAnchor.constraint(equalTo: popularityLabel.trailingAnchor, constant: 10),
            popularityImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            popularityImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            popularityImage.heightAnchor.constraint(equalToConstant: 30),
            popularityImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

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

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
