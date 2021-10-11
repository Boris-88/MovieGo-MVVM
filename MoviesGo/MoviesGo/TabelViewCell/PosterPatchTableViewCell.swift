// PosterPatchTableViewCell.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class PosterPatchTableViewCell: UITableViewCell {
    static var reuseID = "PosterPatchTableViewCell"

    // MARK: - Stored Properties

    var posterPath: String? {
        didSet { update(posterPath: posterPath) }
    }

    // MARK: - PRIVATE PROPERTY

    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 2
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 15, height: 15)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        addSubview(posterImage)
        createConstrainPosterImage()
    }

    private func createConstrainPosterImage() {
        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            posterImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            posterImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - PRIVATE METHODE

    private func update(posterPath: String?) {
        if let posterPath = posterPath, let url = URL(string: posterPath) {
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
}
