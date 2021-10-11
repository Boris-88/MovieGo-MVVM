// MenuViewController.swift
// Copyright © Boris Zverik. All rights reserved.

import UIKit

final class MenuViewController: UIViewController {
    // MARK: - PRIVATE PROPERTY

    private var avatarButton = UIButton()
    private var avatarImageView = UIImageView()
    private var moviesNameLabel = UILabel()
    private var collectionView = GallareCollectionView()
    private var networkLayer = NetWorcLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black
        tabBarController?.tabBar.barTintColor = .white
        setupView()
    }

    // MARK: - PRIVATE METHODE

    private func setupView() {
        createCollectionView()
        createAvatarButton()
        createTitleNC()
        loadData()
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
                self?.collectionView.pageDataMovie = data
            }
        }
    }

    private func createCollectionView() {
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.onSelectedID = { [weak self] id in
            let descriptionVC = DescriptionViewController()
            descriptionVC.id = id
            self?.navigationController?.pushViewController(descriptionVC, animated: true)
        }
    }

    private func createTitleNC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Смотреть"
        tabBarController?.tabBar.barTintColor = .white
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
        avatarButton.addTarget(self, action: #selector(showAvatar), for: .touchUpInside)
        guard let data = UserDefaults.standard.value(forKey: "avatar") as? Data else { return }
        let image = UIImage(data: data)?.resizeImage(to: CGSize(width: 35, height: 35))
        avatarButton.setImage(image, for: .normal)
        view.addSubview(avatarButton)
    }

    @objc private func showAvatar() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    @objc private func touchHandleTap(sender: UIGestureRecognizer) {
        let descriptionVC = DescriptionViewController()
        navigationController?.pushViewController(descriptionVC, animated: true)
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
