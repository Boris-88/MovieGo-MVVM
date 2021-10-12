// MenuViewController + Extension.swift
// Copyright © Boris. All rights reserved.

import UIKit

extension MenuViewController {
    func makeAvatarButton() -> UIButton {
        let avatarButton = UIButton()
        avatarButton.layer.cornerRadius = 17
        avatarButton.layer.masksToBounds = true
        avatarButton.clipsToBounds = true
        avatarButton.layer.borderWidth = 1
        avatarButton.layer.borderColor = UIColor.systemGray.cgColor
        view.addSubview(avatarButton)
        return avatarButton
    }

    func makeAvatarImageView() -> UIImageView {
        avatarImageView.image = UIImage(named: "avatar")
        avatarImageView.clipsToBounds = true
        avatarButton.addSubview(avatarImageView)
        return avatarImageView
    }

    func makeCollectionView() -> UICollectionView {
        let layot = UICollectionViewFlowLayout()
        layot.scrollDirection = .vertical
        layot.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layot)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            CollectionViewCell.self,
            forCellWithReuseIdentifier: CollectionViewCell.reuseID
        )
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        return collectionView
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
