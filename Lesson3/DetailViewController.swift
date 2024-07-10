import UIKit

class DetailViewController: UIViewController {
    var movie: Movie?

    @IBOutlet weak var movieImageView2: UIImageView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            let blurredImage = applyBlurEffect(to: movie.image)
            movieImageView2.image = blurredImage
            movieImageView.image = movie.image
            titleLabel.attributedText = createStrokeText(text: movie.title, fontSize: titleLabel.font.pointSize)
            genreLabel.text = movie.genre
            ratingLabel.text = movie.rating
            descriptionLabel.text = movie.desctiption

        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.sendSubviewToBack(movieImageView2)
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func leaveReviewButtonTapped(_ sender: UIButton) {
        if let reviewVC = storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController {
            reviewVC.movie = movie
            present(reviewVC, animated: true, completion: nil)
        }
    }

    private func applyBlurEffect(to image: UIImage) -> UIImage? {
        let context = CIContext(options: nil)
        guard let inputImage = CIImage(image: image) else { return nil }
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(20.0, forKey: kCIInputRadiusKey)
        
        guard let outputImage = filter?.outputImage else { return nil }
        guard let cgImage = context.createCGImage(outputImage, from: inputImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
    }

    private func createStrokeText(text: String, fontSize: CGFloat) -> NSAttributedString {
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.black,
            .strokeWidth: -3.0,
            .font: UIFont.boldSystemFont(ofSize: fontSize)
        ]
        
        return NSAttributedString(string: text, attributes: strokeTextAttributes)
    }
}
