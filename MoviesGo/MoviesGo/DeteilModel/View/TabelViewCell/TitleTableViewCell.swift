// TitleTableViewCell.swift
// Copyright © Boris. All rights reserved.

import UIKit

final class TitleTableViewCell: UITableViewCell {
    static var reuseID = "TitleTableViewCell"

    // MARK: - Stored Properties

    var title: String? {
        didSet { titleMovieLabel.text = title }
    }

    // MARK: - PRIVATE PROPERTY

    private let titleMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleMovieLabel)
        backgroundColor = .black
        titleMovieLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleMovieLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleMovieLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleMovieLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
