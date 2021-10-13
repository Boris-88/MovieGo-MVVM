// DescriptionViewController.swift
// Copyright © Boris. All rights reserved.

import UIKit

final class DescriptionViewController: UIViewController {
    private enum TypeCell {
        case poster
        case title
        case overview
        case releaseDate
    }

    // MARK: - Private properties

    private let tabelView = UITableView()
    private let typeCells: [TypeCell] = [.poster, .title, .releaseDate, .overview]
    private var viewModel: DetailsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        createTitleNC()
        createTabelView()
        reloadDataView()
    }

    func injectionViewModel(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - Private functions

    private func reloadDataView() {
        viewModel.loadData()
        viewModel.updateData = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }

        viewModel.showError = { [weak self] errorText, isReload, completion in
            let alert = UIAlertController(title: errorText, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
            if isReload {
                alert.addAction(UIAlertAction(title: "Reload", style: .default) { _ in
                    completion()
                })
            }
            self?.present(alert, animated: true)
        }
    }

    private func createTitleNC() {
        navigationController?.overrideUserInterfaceStyle = .dark
        tabBarController?.tabBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func createTabelView() {
        tabelView.frame = view.bounds
        tabelView.backgroundColor = .black
        tabelView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.reuseID)
        tabelView.register(
            PosterPatchTableViewCell.self,
            forCellReuseIdentifier: PosterPatchTableViewCell.reuseID
        )
        tabelView.register(
            ReleaseTableViewCell.self,
            forCellReuseIdentifier: ReleaseTableViewCell.reuseID
        )
        tabelView.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.reuseID)
        view.addSubview(tabelView)
        tabelView.delegate = self
        tabelView.dataSource = self
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

            if let posterPath = viewModel.details?.posterPath {
                cell.configCell(posterPath: posterPath)
            }
            return cell

        case .title:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TitleTableViewCell.reuseID,
                for: indexPath
            ) as? TitleTableViewCell else { return UITableViewCell() }
            cell.title = viewModel.details?.title
            return cell

        case .releaseDate:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReleaseTableViewCell.reuseID,
                for: indexPath
            ) as? ReleaseTableViewCell else { return UITableViewCell() }
            cell.releaseDate = viewModel.details?.releaseDate
            cell.popularyMovie = viewModel.details?.voteAverage
            return cell

        case .overview:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: OverviewTableViewCell.reuseID,
                for: indexPath
            ) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.overview = viewModel.details?.overview
            return cell
        }
    }
}
