//
//  ViewController.swift
//  QRReader_PoC
//
//  Created by tomoyaitagaki on 2020/07/21.
//  Copyright © 2020 eversense. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var qrCodeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        super.viewDidLoad()

        let urlText = "https://www.google.com/"

        let image = UIImage.makeQRCode(text: urlText)

        self.qrCodeImageView.image = image
    }
}


extension UIImage {
    /**
     文字列からQRコードを作成します
     - parameters:
         - text: 読み込んだ時のデータ文字列
     */
    static func makeQRCode(text: String) -> UIImage? {
        guard let data = text.data(using: .utf8) else { return nil }
        guard let QR = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data]) else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        guard let ciImage = QR.outputImage?.transformed(by: transform) else { return nil }
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
