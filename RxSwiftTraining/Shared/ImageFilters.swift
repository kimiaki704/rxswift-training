//
//  ImageFilters.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/06/06.
//  Copyright © 2020 kimioman. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

class ImageFilters {
    private var context: CIContext

    init() {
        self.context = CIContext()
    }

    func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        let filter = CIFilter(name: "CICMYKHalftone")
        filter!.setValue(5.0, forKey: kCIInputWidthKey)

        if let sourceImage = CIImage(image: inputImage) {
            filter!.setValue(sourceImage, forKey: kCIInputImageKey)

            guard let outputImage = filter!.outputImage else { return }

            if let cgimg = self.context.createCGImage(outputImage, from: outputImage.extent) {
                let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
    }
}
