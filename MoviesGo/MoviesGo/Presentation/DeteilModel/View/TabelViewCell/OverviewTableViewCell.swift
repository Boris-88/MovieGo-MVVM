// OverviewTableViewCell.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class OverviewTableViewCell: UITableViewCell {
    static var reuseID = "OverviewTableViewCell"

    // MARK: - Stored Properties

    var overview: String? {
        didSet { overviewMovieTextView.text = overview }
    }

    // MARK: - PRIVATE PROPERTY

    private let overviewMovieTextView: UITextView = {
        let text = UITextView()
        text.textAlignment = .left
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.textColor = .white
        text.backgroundColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private let overviewMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.contentMode = .top
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.text = "Описание:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        addSubview(overviewMovieTextView)
        addSubview(overviewMovieLabel)
        createConstrainOverviewMovieTextView()
        createConstrainOverviewMovieLabel()
    }

    private func createConstrainOverviewMovieTextView() {
        NSLayoutConstraint.activate([
            overviewMovieTextView.leadingAnchor.constraint(equalTo: overviewMovieLabel.trailingAnchor, constant: 10),
            overviewMovieTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overviewMovieTextView.topAnchor.constraint(equalTo: topAnchor),
            overviewMovieTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createConstrainOverviewMovieLabel() {
        NSLayoutConstraint.activate([
            overviewMovieLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            overviewMovieLabel.topAnchor.constraint(equalTo: topAnchor),
            overviewMovieLabel.heightAnchor.constraint(equalToConstant: 30),
            overviewMovieLabel.widthAnchor.constraint(equalToConstant: 85)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
