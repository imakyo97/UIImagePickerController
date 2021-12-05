//
//  ImageViewController.swift
//  UIImagePickerController-Sample
//
//  Created by 今村京平 on 2021/12/05.
//

import UIKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ImageViewController {
    static func instantiate() -> ImageViewController {
        let storyBoard = UIStoryboard(name: "ImageViewController", bundle: nil)
        let imageViewController = storyBoard.instantiateInitialViewController() as! ImageViewController
        return imageViewController
    }
}
