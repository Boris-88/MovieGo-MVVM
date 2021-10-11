// OfishaViewController.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class OfishaViewController: UIViewController {
    // MARK: - Stored properties

    var pageDataMovie: PageDataMovie? {
        didSet { tabelView.reloadData() }
    }

    private var detailsMovie: DetailsMovie? {
        didSet { tabelView.reloadData() }
    }

    var onSelectedID: ((Int) -> Void)?
    var id: Int?

    // MARK: - Private properties

    private let tabelView = UITableView()
    private var networkLayer = NetWorcLayer()

    // MARK: - Live Circle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black
        view.addSubview(tabelView)
        createTabelView()
        createTitleNC()
        loadData()
    }

    // MARK: - Private functions

    private func createTitleNC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Смотреть"
        tabBarController?.tabBar.barTintColor = .white
    }

    private func loadData() {
        networkLayer.fetchData(PageDataMovie.self, methodStr: "movie/popular") { [weak self] result in
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
                self?.pageDataMovie = data
            }
        }
    }

    private func createTabelView() {
        tabelView.frame = view.bounds
        tabelView.backgroundColor = .black
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.register(OfishaTableViewCell.self, forCellReuseIdentifier: OfishaTableViewCell.indentifier)
    }
}

// MARK: - UITableViewDelegate

extension OfishaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = pageDataMovie?.movies[indexPath.row].id else { return }
        let nextVC = DescriptionViewController()
        nextVC.id = id
        navigationController?.pushViewController(nextVC, animated: true)
        onSelectedID?(id)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0.2
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }
}

// MARK: - UITableViewDataSource

extension OfishaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pageDataMovie?.movies.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tabelView
            .dequeueReusableCell(withIdentifier: OfishaTableViewCell.indentifier) as? OfishaTableViewCell
        else { return UITableViewCell() }
        if let pageDataMovie = pageDataMovie {
            let movie = pageDataMovie.movies[indexPath.row]
            cell.update(mainHost: AppSetting.imageHost, posterPath: movie.posterPath)
            cell.titleData = movie.title
            cell.overviewData = movie.overview
            cell.popularyData = movie.voteAverage
            cell.releaseData = movie.releaseDate
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        230
    }
}
