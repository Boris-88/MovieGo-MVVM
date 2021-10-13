// MenuViewController.swift
// Copyright © Boris. All rights reserved.

import UIKit

final class MenuViewController: UIViewController {
    // MARK: - public properties

    lazy var avatarButton = makeAvatarButton()
    lazy var avatarImageView = makeAvatarImageView()
    lazy var collectionView = makeCollectionView()
    lazy var activitiIndicator = makeActivityIndicator()

    // MARK: - Private properties

    private let titleActionAlert = "Обновить"
    private let titleActionAlertCancle = "Отмена"
    private let titleAlertERROR = "Ошибка!"
    private var viewModel: MenuViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        reloadDataView()
    }
    // MARK: - Public functions
    
    func injectionViewModel(viewModel: MenuViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - Private functions

    private func setupView() {
        createAvatarButton()
        createTitleNC()
    }

    private func reloadDataView() {
        viewModel.updateData = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        // Сообщение об ошибки
        viewModel.showError = { [weak self] errorText, isReload, completion in
            guard let self = self else { return }
            self.alertShowComplition(
                title: self.titleAlertERROR ,
                message: errorText,
                isAction: isReload,
                buttonAction: self.titleActionAlert,
                selectButtonAction: self.titleActionAlertCancle,
                comlitionHandler: completion
            )
        }
    }

    private func createAvatarButton() {
        let barButton = UIBarButtonItem()
        barButton.customView = avatarButton
        navigationItem.rightBarButtonItem = barButton
        avatarButton.addTarget(self, action: #selector(tapShowAvatarButton), for: .touchUpInside)
        guard let data = UserDefaults.standard.value(forKey: "avatar") as? Data else { return }
        let image = UIImage(data: data)?.resizeImage(to: CGSize(width: 40, height: 40))
        avatarButton.setImage(image, for: .normal)
    }

    private func createTitleNC() {
        navigationController?.overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Смотреть"
        tabBarController?.tabBar.barTintColor = .white
    }

    @objc public func tapShowAvatarButton() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieUD = viewModel.pageDataMovie?.movies[indexPath.row].id else { return }
        let vc = DescriptionViewController()
        let movieAPIService = MovieAPIService()
        let detailsViewModel = DetailsViewModel(movieAPIService: movieAPIService, movieID: movieUD)
        vc.injectionViewModel(viewModel: detailsViewModel)
        navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        cell.alpha = 0.2
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                cell.transform = .init(scaleX: 0.85, y: 0.85)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                cell.transform = .identity
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.pageDataMovie?.movies.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.reuseID,
            for: indexPath
        ) as?
            CollectionViewCell else { return UICollectionViewCell() }
        if let item = viewModel.pageDataMovie {
            let movie = item.movies[indexPath.row]
            cell.configCellImage(posterPath: movie.posterPath)
            cell.configurCell(movie: movie)
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 400, height: 200)
    }
}
