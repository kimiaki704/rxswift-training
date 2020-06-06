//
//  UIImage+Extension.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/06/06.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit
import CoreImage
import RxSwift

extension UIImage {

    func applyFilter() -> Observable<UIImage> {
        return Observable.create { observer in
            self.applyFilter() { filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }

    private func applyFilter(completion: @escaping ((UIImage) -> ())) {
        let context = CIContext()
        let filter = CIFilter(name: "CICMYKHalftone")
        filter!.setValue(5.0, forKey: kCIInputWidthKey)
        if let sourceImage = CIImage(image: self) {
            filter!.setValue(sourceImage, forKey: kCIInputImageKey)
            guard let outputImage = filter!.outputImage else { return }
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let processedImage = UIImage(cgImage: cgimg, scale: self.scale, orientation: self.imageOrientation)
                completion(processedImage)
            }
        }
    }
}
