//
//  ImageViewController.swift
//  UIImagePickerController-Sample
//
//  Created by 今村京平 on 2021/12/05.
//

import UIKit

class ImageViewController: UIViewController,
                           UIImagePickerControllerDelegate,
                           UINavigationControllerDelegate {
    @IBOutlet private weak var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func didTapCameraShooting(_ sender: Any) {
        let sourceType = UIImagePickerController.SourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }

    @IBAction private func didTapPhotoLibrary(_ sender: Any) {
        let sourceType = UIImagePickerController.SourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }

    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            photoImageView.contentMode = .scaleAspectFit
            photoImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ImageViewController {
    static func instantiate() -> ImageViewController {
        let storyBoard = UIStoryboard(name: "ImageViewController", bundle: nil)
        let imageViewController = storyBoard.instantiateInitialViewController()
        as! ImageViewController // swiftlint:disable:this force_cast
        return imageViewController
    }
}
