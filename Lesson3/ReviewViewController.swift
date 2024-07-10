import UIKit

class ReviewViewController: UIViewController, UITextViewDelegate {
    var movie: Movie?

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            movieImageView.image = movie.image
            titleLabel.text = movie.title

            // Закругление углов изображения фильма
            movieImageView.layer.cornerRadius = 10
            movieImageView.clipsToBounds = true
        }
        ratingSlider.minimumValue = 0
        ratingSlider.maximumValue = 10
        ratingSlider.value = 5
        updateRatingLabel()
        
        ratingSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        // Установка делегата для UITextView
        reviewTextView.delegate = self

        // Добавление жеста для скрытия клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func sliderValueChanged(_ sender: UISlider) {
        updateRatingLabel()
    }

    private func updateRatingLabel() {
        let rating = round(ratingSlider.value * 10) / 10.0
        ratingLabel.text = "\(rating)"
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let reviewText = reviewTextView.text, !reviewText.isEmpty else {
            let alert = UIAlertController(title: "Ошибка", message: "Пожалуйста, напишите текст отзыва.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let alert = UIAlertController(title: "Спасибо за Ваше мнение!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })
        }))
        present(alert, animated: true, completion: nil)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

