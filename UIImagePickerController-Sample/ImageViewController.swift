//
//  ImageViewController.swift
//  UIImagePickerController-Sample
//
//  Created by 今村京平 on 2021/12/05.
//

import UIKit
import PhotosUI

class ImageViewController: UIViewController,
                           UIImagePickerControllerDelegate,
                           UINavigationControllerDelegate,
                           PHPickerViewControllerDelegate {
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
        let configuration = PHPickerConfiguration()
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
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

    // MARK: - PHPickerViewControllerDelegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                DispatchQueue.main.async {
                    guard let strongSelf = self, let image = image as? UIImage else { return }
                    strongSelf.photoImageView.image = image
                }
            }
        }
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
