import UIKit

class FirstTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieImageView2: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    private var gradientLayer: CAGradientLayer!

    func config(user: Movie) {
        let blurredImage = applyBlurEffect(to: user.image)
        movieImageView2.image = blurredImage
        movieImageView.image = user.image
        titleLabel.text = user.title
        genreLabel.text = user.genre
        ratingLabel.text = user.rating
    }

    private func applyBlurEffect(to image: UIImage) -> UIImage? {
        let context = CIContext(options: nil)
        guard let inputImage = CIImage(image: image) else { return nil }
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(50.0, forKey: kCIInputRadiusKey)

        guard let outputImage = filter?.outputImage else { return nil }
        guard let cgImage = context.createCGImage(outputImage, from: inputImage.extent) else { return nil }

        return UIImage(cgImage: cgImage)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        applyGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }

    private func applyGradient() {
        gradientLayer = CAGradientLayer()
        let backgroundColor: UIColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        gradientLayer.colors = [backgroundColor.withAlphaComponent(0.0).cgColor,
                                backgroundColor.cgColor,
                                backgroundColor.withAlphaComponent(0.0).cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
