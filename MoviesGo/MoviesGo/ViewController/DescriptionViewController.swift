// DescriptionViewController.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class DescriptionViewController: UIViewController {
    private enum TypeCell {
        case poster
        case title
        case overview
        case releaseDate
    }

    // MARK: - PRIVATE PROPERTY

    private let descriptionTabelView = UITableView()
    private let typeCells: [TypeCell] = [.poster, .title, .releaseDate, .overview]
    private var moviesImage = UIImageView()
    private var nameMoviesLabel = UILabel()
    private var descriptionMoviesText = UITextView()
    private var releaseDate = UILabel()
    private var networkLayer = NetWorcLayer()
    private var detailsMovie: DetailsMovie? {
        didSet {
            descriptionTabelView.reloadData()
        }
    }

    var id: Int?
    var onSelectedID: ((Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.overrideUserInterfaceStyle = .dark
        tabBarController?.tabBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = detailsMovie?.title
        createDescriptionTabelView()
        loadData()
    }

    private func loadData() {
        if let id = id {
            networkLayer.fetchData(DetailsMovie.self, methodStr: "movie/\(id)") { [weak self] result in
                switch result {
                case let .failure(error):
                    switch error {
                    case let .failure(error):
                        print("Ошибка связи с Бэк Error: \(error.localizedDescription)")
                    case .failureDecode:
                        print("Ошибка декодирования")
                    case .notData:
                        print("Отсуствуют данные")
                    }
                case let .success(data):
                    self?.detailsMovie = data
                }
            }
        }
    }

    // MARK: - PRIVATE METHODE

    private func createDescriptionTabelView() {
        descriptionTabelView.frame = view.bounds
        descriptionTabelView.backgroundColor = .black
        descriptionTabelView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.reuseID)
        descriptionTabelView.register(
            PosterPatchTableViewCell.self,
            forCellReuseIdentifier: PosterPatchTableViewCell.reuseID
        )
        descriptionTabelView.register(
            ReleaseTableViewCell.self,
            forCellReuseIdentifier: ReleaseTableViewCell.reuseID
        )
        descriptionTabelView.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.reuseID)
        view.addSubview(descriptionTabelView)
        descriptionTabelView.delegate = self
        descriptionTabelView.dataSource = self
    }
}

// MARK: - PRIVATE UITableViewDelegate

extension DescriptionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let typeCell = typeCells[indexPath.row]
        switch typeCell {
        case .poster: return 400
        case .title: return 70
        case .releaseDate: return 70
        case .overview: return 300
        }
    }
}

// MARK: - PRIVATE UITableViewDataSource

extension DescriptionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        typeCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeCell = typeCells[indexPath.row]
        switch typeCell {
        case .poster:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PosterPatchTableViewCell.reuseID,
                for: indexPath
            ) as? PosterPatchTableViewCell else { return UITableViewCell() }

            if let posterPath = detailsMovie?.posterPath {
                cell.posterPath = AppSetting.imageHost + posterPath
            }
            return cell

        case .title:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TitleTableViewCell.reuseID,
                for: indexPath
            ) as? TitleTableViewCell else { return UITableViewCell() }
            cell.title = detailsMovie?.title
            return cell

        case .releaseDate:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReleaseTableViewCell.reuseID,
                for: indexPath
            ) as? ReleaseTableViewCell else { return UITableViewCell() }
            cell.releaseDate = detailsMovie?.releaseDate
            cell.popularyMovie = detailsMovie?.voteAverage
            return cell

        case .overview:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: OverviewTableViewCell.reuseID,
                for: indexPath
            ) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.overview = detailsMovie?.overview
            return cell
        }
    }
}
