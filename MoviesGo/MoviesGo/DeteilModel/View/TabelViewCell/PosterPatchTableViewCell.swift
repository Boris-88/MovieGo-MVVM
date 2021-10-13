// PosterPatchTableViewCell.swift
// Copyright © Boris. All rights reserved.

import UIKit

final class PosterPatchTableViewCell: UITableViewCell {
    static var reuseID = "PosterPatchTableViewCell"

    // MARK: - PRIVATE PROPERTY

    private let serviceImage = ImageAPIService()
    private var posterImage: UIImageView = {
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

    func configCell(posterPath: String) {
        serviceImage.updateImage(posterPath: posterPath) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(image):
                self.posterImage.image = image
            case let .failure(error):
                self.posterImage.image = UIImage(named: "error")
                print(error.localizedDescription)
            }
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
