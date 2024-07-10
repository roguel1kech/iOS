import UIKit

struct NewsItem {
    let title: String
    let description: String
    let imageURL: String
    let detailedDescription: String
}

class NewsTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let newsImageView = UIImageView()
    let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(white: 0.2, alpha: 1) : UIColor(white: 0.8, alpha: 1)
        }
        
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        newsImageView.layer.cornerRadius = 10
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .lightGray : .darkGray
        }
        
        let textStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        textStackView.axis = .vertical
        textStackView.spacing = 4
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let mainStackView = UIStackView(arrangedSubviews: [newsImageView, textStackView])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 12
        mainStackView.alignment = .center
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(mainStackView)
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            newsImageView.widthAnchor.constraint(equalToConstant: 80),
            newsImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with news: NewsItem) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        if let url = URL(string: news.imageURL) {
            downloadImage(from: url)
        }
    }
    
    private func downloadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.newsImageView.image = UIImage(data: data)
            }
                    }
                    task.resume()
                }
            }

            class NewsDetailViewController: UIViewController {
                var newsItem: NewsItem?
                
                let imageView = UIImageView()
                let titleLabel = UILabel()
                let descriptionLabel = UILabel()
                let closeButton = UIButton(type: .system)
                
                override func viewDidLoad() {
                    super.viewDidLoad()
                    view.backgroundColor = .systemBackground
                    
                    setupViews()
                    
                    if let newsItem = newsItem {
                        configure(with: newsItem)
                        descriptionLabel.text = newsItem.detailedDescription
                        
                    }
                }
                
                private func setupViews() {
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    imageView.layer.cornerRadius = 20
                    
                    titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
                    titleLabel.numberOfLines = 0
                    titleLabel.translatesAutoresizingMaskIntoConstraints = false
                    titleLabel.shadowColor = .lightGray
                    titleLabel.shadowOffset = CGSize(width: 1, height: 1)
                    titleLabel.textAlignment = .center
                    
                    
                    descriptionLabel.font = UIFont.systemFont(ofSize: 19)
                    descriptionLabel.numberOfLines = 0
                    descriptionLabel.textAlignment = .center
                    

                    closeButton.setTitle("Закрыть", for: .normal)
                    closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
                    closeButton.translatesAutoresizingMaskIntoConstraints = false
                    closeButton.tintColor = .white
                    closeButton.backgroundColor = .darkGray
                    closeButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
                    closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
                    closeButton.layer.cornerRadius = 17
                    
                    
                    let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel])
                    stackView.axis = .vertical
                    stackView.spacing = 12
                    stackView.translatesAutoresizingMaskIntoConstraints = false
                    
                    view.addSubview(stackView)
                    view.addSubview(closeButton)
                    
                    NSLayoutConstraint.activate([
                        imageView.heightAnchor.constraint(equalToConstant: 300),
                        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                        
                        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
                        stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16),
                        
                        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        closeButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20)
                        
                    ])
                }
                
                func configure(with news: NewsItem) {
                    titleLabel.text = news.title
                    descriptionLabel.text = news.description
                    if let url = URL(string: news.imageURL) {
                        downloadImage(from: url)
                    }
                }
                
                private func downloadImage(from url: URL) {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                    task.resume()
                }
                
                @objc private func closeButtonTapped() {
                    dismiss(animated: true, completion: nil)
                }
            }
class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    let news: [NewsItem] = [
        NewsItem(
            title: "Мировая премьера фильма \"Оппенгеймер\"",
            description: "Вышел новый фильм Кристофера Нолана о создателе атомной бомбы.",
            imageURL: "https://images.kinorium.com/movie/fanart/2828885/w1500_51539713.jpg",
            detailedDescription: "Фильм рассказывает о жизни и карьере физика Роберта Оппенгеймера, которого называют \"отцом атомной бомбы\". Премьера прошла с большим успехом, получив высокие оценки критиков за режиссуру и игру актёров. Этот фильм – одно из самых ожидаемых событий года, и поклонники кино уже могут наслаждаться этой удивительной историей на больших экранах."
        ),
        NewsItem(
            title: "Фестиваль \"Каннские львы\"",
            description: "На фестивале представлены лучшие работы в области киноискусства.",
            imageURL: "https://i07.fotocdn.net/s204/5efee2a486303756/public_pin_l/2288114667.jpg",
            detailedDescription: "Фестиваль \"Каннские львы\" ежегодно привлекает лучшие фильмы со всего мира. В этом году было представлено множество выдающихся картин, получивших признание жюри и зрителей. Фестиваль продолжает устанавливать высокие стандарты в мире киноискусства и открывать новые таланты."
        ),
        NewsItem(
            title: "Ремейк фильма \"Король Лев\"",
            description: "Ремейк классического мультфильма \"Король Лев\" выходит в кинотеатры.",
            imageURL: "https://24smi.org/public/media/movie/2021/11/18/z5jxehmgm2v1-korol-lev.jpg",
            detailedDescription: "Ремейк классического мультфильма \"Король Лев\" выходит в кинотеатры и обещает стать новым любимцем публики. С использованием новейших технологий компьютерной графики, этот фильм оживляет знакомых персонажей и истории на новом уровне. Поклонники оригинала уже с нетерпением ждут выхода ремейка."
        ),
        NewsItem(
            title: "Новый фильм от Marvel",
            description: "Marvel анонсировала выход нового супергеройского фильма.",
            imageURL: "https://cdn.marvel.com/content/1x/deadpoolandwolverine_lob_crd_02.jpg",
            detailedDescription: "Marvel анонсировала выход нового супергеройского фильма, который обещает стать новым хитом. Фильм представит новых персонажей и продолжит истории уже знакомых героев. Поклонники Marvel уже в предвкушении, ожидая новых приключений и эпических сражений."
        ),
        NewsItem(
            title: "Премия \"Оскар\"",
            description: "Вручение наград Американской киноакадемии состоится в ближайшие выходные.",
            imageURL: "https://upload.wikimedia.org/wikipedia/ru/c/c0/Oscar_89_%282017%29_poster.jpg",
            detailedDescription: "Вручение наград Американской киноакадемии состоится в ближайшие выходные. Церемония \"Оскар\" – одно из самых престижных событий в мире кино, где отмечаются лучшие фильмы и достижения года. Зрители и номинанты с нетерпением ждут объявления победителей."
        ),
        NewsItem(
            title: "Фильм \"Дюна\"",
            description: "Фильм \"Дюна\" по роману Фрэнка Герберта получил множество положительных отзывов.",
            imageURL: "https://avatars.mds.yandex.net/get-kinopoisk-image/9784475/0c67265b-6631-4e25-b89c-3ddf4e5a1ee7/600x900",
            detailedDescription: "Фильм \"Дюна\" по роману Фрэнка Герберта получил множество положительных отзывов как от критиков, так и от зрителей. Режиссёрская работа, визуальные эффекты и актёрский состав были высоко оценены. Этот эпический фильм обещает стать классикой научной фантастики."
        ),
        NewsItem(
            title: "Сиквел \"Аватар\"",
            description: "Джеймс Кэмерон анонсировал сиквел \"Аватара\".",
            imageURL: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSmGggtpJ4TX3aN3PUaVWUgNODHespRPvKYAyhGUAZSqSOmPiEm",
            detailedDescription: "Джеймс Кэмерон анонсировал сиквел \"Аватара\", который продолжит историю жителей Пандоры. Сиквел обещает еще более захватывающие спецэффекты и глубокий сюжет. Поклонники первого фильма с нетерпением ждут продолжения этой эпической саги."
        ),
        NewsItem(
            title: "Фильм \"Матрица\"",
            description: "Четвертая часть фильма \"Матрица\" выходит в декабре.",
            imageURL: "https://ir-3.ozone.ru/s3/multimedia-p/c1000/6173994253.jpg",
            detailedDescription: "Четвертая часть фильма \"Матрица\" выходит в декабре и обещает вернуть зрителей в мир виртуальной реальности и борьбы за свободу. Режиссеры и актерский состав обещают продолжение, которое будет не менее захватывающим, чем предыдущие части."
        ),
        NewsItem(
            title: "Фильм \"Бэтмен\"",
            description: "Новый фильм о Бэтмене выходит на экраны в следующем году.",
            imageURL: "https://thumbs.dfs.ivi.ru/storage5/contents/3/b/0d5de29534357c386470875cabb776.jpg",
            detailedDescription: "Новый фильм о Бэтмене выходит на экраны в следующем году, представляя новую интерпретацию классического супергероя. Сюжет фильма и актерский состав пока держатся в секрете, но фанаты уже ждут с нетерпением новых приключений Темного Рыцаря."
        ),
        NewsItem(
            title: "Фильм \"Начало\"",
            description: "Фильм \"Начало\" Кристофера Нолана продолжает удивлять зрителей.",
            imageURL: "https://b1.filmpro.ru/c/5570.jpg",
            detailedDescription: "Фильм \"Начало\" Кристофера Нолана продолжает удивлять зрителей своей сложной и захватывающей историей. С момента выхода фильм стал культовым и до сих пор вызывает интерес и восхищение у зрителей."
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        title = "Новости"
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : UIColor(white: 0.95, alpha: 1)
        }
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let newsItem = news[indexPath.row]
        cell.configure(with: newsItem)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsItem = news[indexPath.row]
        let detailVC = NewsDetailViewController()
        detailVC.newsItem = newsItem
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        let cellFrame = tableView.convert(selectedCell.frame, to: tableView.superview)
        let overlayView = UIView(frame: cellFrame)
                overlayView.backgroundColor = selectedCell.containerView.backgroundColor
                overlayView.layer.cornerRadius = 10
                overlayView.layer.shadowColor = UIColor.black.cgColor
                overlayView.layer.shadowOpacity = 0.1
                overlayView.layer.shadowOffset = CGSize(width: 0, height: 2)
                overlayView.layer.shadowRadius = 4
                
                let newsImageView = UIImageView(image: selectedCell.newsImageView.image)
                newsImageView.contentMode = .scaleAspectFill
                newsImageView.clipsToBounds = true
                newsImageView.layer.cornerRadius = 10
                newsImageView.frame = CGRect(x: 12, y: 12, width: 80, height: 80)
                
                let titleLabel = UILabel()
                titleLabel.text = newsItem.title
                titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
                titleLabel.numberOfLines = 0
                titleLabel.textColor = selectedCell.titleLabel.textColor
                titleLabel.frame = CGRect(x: 104, y: 12, width: cellFrame.width - 116, height: 0)
                titleLabel.sizeToFit()
                
                let descriptionLabel = UILabel()
                descriptionLabel.text = newsItem.description
                descriptionLabel.font = UIFont.systemFont(ofSize: 18)
                descriptionLabel.numberOfLines = 0
                descriptionLabel.textColor = selectedCell.descriptionLabel.textColor
                descriptionLabel.frame = CGRect(x: 104, y: titleLabel.frame.maxY + 4, width: cellFrame.width - 116, height: 0)
                descriptionLabel.sizeToFit()
                
                overlayView.addSubview(newsImageView)
                overlayView.addSubview(titleLabel)
                overlayView.addSubview(descriptionLabel)
                
                view.addSubview(overlayView)
                
        UIView.animate(withDuration: 0.7, animations: {
                    overlayView.frame = self.view.bounds
                    overlayView.backgroundColor = UIColor { traitCollection in
                        return traitCollection.userInterfaceStyle == .dark ? .black : .white
                    }
                    newsImageView.frame = CGRect(x: 16 , y: 60, width: 400, height: 300)
            newsImageView.layer.cornerRadius = 20
                    titleLabel.frame = CGRect(x: 16, y: newsImageView.frame.maxY + 16, width: self.view.bounds.width - 32, height: 0)
            titleLabel.textColor = .black
                    descriptionLabel.frame = CGRect(x: 16, y: titleLabel.frame.maxY + 8, width: self.view.bounds.width - 32, height: 0)
                    descriptionLabel.textColor = .black
                }) { _ in
                    self.present(detailVC, animated: true) {
                        overlayView.removeFromSuperview()
                    }
                }
            }
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return view.bounds.height / 5
            }
        }
