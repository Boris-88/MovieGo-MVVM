// OfishaTableViewCell.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class OfishaTableViewCell: UITableViewCell {
    // MARK: - Static properties

    static let indentifier = "OfishaTableViewCell"

    // MARK: - Stored properties

    var labelData: String? {
        didSet { titleLabel.text = labelData }
    }

    var overviewData: String? {
        didSet { overviewLebel.text = overviewData }
    }

    var releaseData: String? {
        didSet { releaseLabel.text = convertDataFormatter(releaseData) }
    }

    var popularyData: Double? {
        didSet { popularityLabel.text = String(format: "%.1f", popularyData ?? 00) }
    }

    var titleData: String? {
        didSet { titleLabel.text = titleData }
    }

    var onSelectedID: ((Int) -> Void)?
    var id: Int?

    // MARK: - Private properties

    private var networkLayer = NetWorcLayer()
    private var detailsMovie: DetailsMovie?

    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.contentMode = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.contentMode = .top
        label.font = UIFont.italicSystemFont(ofSize: 16)
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

    private let overviewLebel: UILabel = {
        let lebel = UILabel()
        lebel.textAlignment = .left
        lebel.numberOfLines = 0
        lebel.font = UIFont.italicSystemFont(ofSize: 16)
        lebel.textColor = .white
        lebel.translatesAutoresizingMaskIntoConstraints = false
        return lebel
    }()

    private let subView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Live Cirle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(subView)
        subView.addSubview(posterImage)
        subView.addSubview(titleLabel)
        subView.addSubview(releaseLabel)
        subView.addSubview(popularityLabel)
        subView.addSubview(popularityImage)
        subView.addSubview(overviewLebel)
        setupConstraints()
    }

    // MARK: - Public function

    func update(mainHost: String, posterPath: String?) {
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

    // MARK: - Private functions

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

    private func setupConstraints() {
        createConstraintsSubView()
        createConstraintsPosterImage()
        createConstraintsTitleLabel()
        createConstraintsReleaseLabel()
        createConstraintsOverviewLebel()
        createConstraintsPopularityImage()
        createConstraintsPopularityLabel()
    }

    private func createConstraintsPosterImage() {
        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            posterImage.topAnchor.constraint(equalTo: subView.topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: subView.bottomAnchor),
            posterImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func createConstraintsTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 5),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func createConstraintsReleaseLabel() {
        NSLayoutConstraint.activate([
            releaseLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            releaseLabel.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -10),
            releaseLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 50),
            releaseLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func createConstraintsOverviewLebel() {
        NSLayoutConstraint.activate([
            overviewLebel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            overviewLebel.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -10),
            overviewLebel.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -10),
            overviewLebel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 75)

        ])
    }

    private func createConstraintsPopularityImage() {
        NSLayoutConstraint.activate([
            popularityImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            popularityImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            popularityImage.widthAnchor.constraint(equalToConstant: 30),
            popularityImage.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func createConstraintsPopularityLabel() {
        NSLayoutConstraint.activate([
            popularityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            popularityLabel.trailingAnchor.constraint(equalTo: popularityImage.leadingAnchor),
            popularityLabel.widthAnchor.constraint(equalToConstant: 30),
            popularityLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func createConstraintsSubView() {
        NSLayoutConstraint.activate([
            subView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            subView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            subView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
