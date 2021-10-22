// CollectionViewCell + Extension.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

extension CollectionViewCell {
    func makePosterImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        subView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: subView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: subView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        return imageView
    }

    func makeSubView() -> UIView {
        let subView = UIView()
        subView.layer.cornerRadius = 15
        subView.layer.borderWidth = 2
        subView.layer.borderColor = UIColor.gray.cgColor
        subView.layer.shadowRadius = 2
        subView.layer.shadowOpacity = 0.5
        subView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        subView.layer.shadowColor = UIColor.white.cgColor
        subView.clipsToBounds = true
        subView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subView)
        NSLayoutConstraint.activate([
            subView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            subView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            subView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
        ])
        return subView
    }

    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        subView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: subView.topAnchor, constant: 5),
            label.widthAnchor.constraint(equalToConstant: 150),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
        return label
    }

    func makeReleaseLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.contentMode = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        subView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: subView.topAnchor, constant: 50),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
        return label
    }

    func makePopularityLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.contentMode = .top
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        subView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: popularityImage.leadingAnchor),
            label.widthAnchor.constraint(equalToConstant: 30),
            label.heightAnchor.constraint(equalToConstant: 25)
        ])
        return label
    }

    func makeOverviewLebel() -> UILabel {
        let lebel = UILabel()
        lebel.textAlignment = .left
        lebel.numberOfLines = 0
        lebel.font = UIFont.italicSystemFont(ofSize: 14)
        lebel.textColor = .gray
        lebel.translatesAutoresizingMaskIntoConstraints = false
        subView.addSubview(lebel)
        NSLayoutConstraint.activate([
            lebel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            lebel.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -10),
            lebel.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -10),
            lebel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 75)
        ])
        return lebel
    }

    func makePopularityImage() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: "asterisk")
        image.translatesAutoresizingMaskIntoConstraints = false
        subView.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            image.widthAnchor.constraint(equalToConstant: 30),
            image.heightAnchor.constraint(equalToConstant: 30)
        ])
        return image
    }
}
