// MenuViewController.swift
// Copyright © Boris. All rights reserved.

import UIKit

final class MenuViewController: UIViewController {
    // MARK: - public properties

    lazy var collectionView = makeCollectionView()
    lazy var activitiIndicator = makeActivityIndicator()
    var onSelectID: IntHandler?
    var avatarButton = UIButton()

    // MARK: - Private properties

    private let titleActionAlert = "Обновить"
    private let titleActionAlertCancle = "Отмена"
    private let titleAlertERROR = "Ошибка!"
    private var viewModel: MenuViewModelProtocol!
    private var avatarImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black
        tabBarController?.tabBar.barTintColor = .white
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
                title: self.titleAlertERROR,
                message: errorText,
                isAction: isReload,
                buttonAction: self.titleActionAlert,
                selectButtonAction: self.titleActionAlertCancle,
                comlitionHandler: completion
            )
        }
    }

    private func createAvatarButton() {
        avatarButton.layer.cornerRadius = 17
        avatarButton.layer.masksToBounds = true
        avatarButton.clipsToBounds = true
        avatarButton.layer.borderWidth = 1
        avatarButton.layer.borderColor = UIColor.systemGray.cgColor
        avatarButton.addSubview(avatarImageView)
        avatarImageView.image = UIImage(named: "avatar")
        avatarImageView.clipsToBounds = true
        let barButton = UIBarButtonItem()
        barButton.customView = avatarButton
        navigationItem.rightBarButtonItem = barButton
        avatarButton.addTarget(self, action: #selector(tapShowAvatarButton), for: .touchUpInside)
        guard let data = UserDefaults.standard.value(forKey: "avatar") as? Data else { return }
        let image = UIImage(data: data)?.resizeImage(to: CGSize(width: 35, height: 35))
        avatarButton.setImage(image, for: .normal)
        view.addSubview(avatarButton)
    }

    private func createTitleNC() {
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
        guard let movieID = viewModel.movies?[indexPath.row].id else { return }
        let assembly = Assambly()
        navigationController?.pushViewController(assembly.createDetailsViewModel(movieID: movieID), animated: true)
        onSelectID?(movieID)
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
        viewModel.movies?.count ?? 0
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
        if let movies = viewModel.movies?[indexPath.row] {
            cell.configCellImage(posterPath: movies.posterPath)
            cell.configurCell(movie: movies)
        }
        return cell
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

// MARK: - UIImagePickerControllerDelegate

extension MenuViewController: UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        guard let image = info[.originalImage] as? UIImage else { return }
        let img = image.resizeImage(to: CGSize(width: 35, height: 35))
        avatarButton.setImage(img, for: .normal)
        let imageData = image.pngData()
        UserDefaults.standard.setValue(imageData, forKey: "avatar")
        dismiss(animated: true)
    }
}

// MARK: - Extensions UIImage

extension UIImage {
    func resizeImage(to size: CGSize) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
