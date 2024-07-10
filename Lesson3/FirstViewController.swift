import UIKit

class Movie {
    var image: UIImage
    var title: String
    var genre: String
    var rating: String
    var desctiption: String

    init(image: UIImage, title: String, genre: String, rating: String, desctiption: String) {
        self.title = title
        self.genre = genre
        self.rating = rating
        self.desctiption = desctiption
        self.image = image
    }
}

class FirstViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!

    var dataSource: [Movie] = []
    var filteredDataSource: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Инициализация dataSource с безопасным разворачиванием опционалов
        if let carsImage = UIImage(named: "Тачки.png"),
           let avengersImage = UIImage(named: "Мстители.png"),
           let golovImage = UIImage(named: "Головоломка_2.png"),
           let starwarsImage = UIImage(named: "Звездные_войны.png"),
           let legoImage = UIImage(named: "Лего._Фильм_2.png"),
           let squadImage = UIImage(named: "Отряд_самоубийц.png") {
            dataSource = [
                Movie(image: carsImage, title: "Тачки", genre: "Комедия", rating: "7.5", desctiption: "Неукротимый в своем желании всегда и во всем побеждать гоночный автомобиль «Молния» Маккуин вдруг обнаруживает, что сбился с пути и застрял в маленьком захолустном городке Радиатор-Спрингс, что находится где-то на трассе 66 в Калифорнии."),
                Movie(image: avengersImage, title: "Мстители", genre: "Фантастика/боевик", rating: "7.9", desctiption: "Локи, сводный брат Тора, возвращается, и в этот раз он не один. Земля на грани порабощения, и только лучшие из лучших могут спасти человечество."),
                Movie(image: golovImage, title: "Головоломка 2", genre: "Анимация/приключения", rating: "8.1", desctiption: "Мозг Райли внезапно подвергается капитальному ремонту в тот момент, когда необходимо освободить место для кое-чего совершенно неожиданного: новых эмоций. Радость, Грусть, Гнев, Страх и Отвращение никак не ожидали появления некой Тревожности. И похоже, не только её."),
                Movie(image: starwarsImage, title: "Звездные войны", genre: "Фантастика/приключения", rating: "8.6", desctiption: "Мирная и процветающая планета Набу. Торговая федерация, не желая платить налоги, вступает в прямой конфликт с королевой Амидалой, правящей на планете, что приводит к войне. На стороне королевы и республики в ней участвуют два рыцаря-джедая: учитель и ученик, Квай-Гон-Джин и Оби-Ван Кеноби..."),
                Movie(image: legoImage, title: "Лего. Фильм 2", genre: "Анимация/комедия", rating: "7.0", desctiption: "Постапокалиптический мир LEGO переживает новую катастрофу – вторжение пришельцев с планеты DUPLO. Когда они похищают Люси, Бэтмена и многих других жителей Кирпич-града, простодушный строитель Эммет Блоковски отправляется в другую Галактику на спасение друзей и любимой девушки."),
                Movie(image: squadImage, title: "Отряд самоубийц", genre: "Боевик/фантастика", rating: "6.0", desctiption: "Правительство решает дать команде суперзлодеев шанс на искупление. Подвох в том, что их отправляют на миссию, где они, вероятнее всего, погибнут.")
            ]
            filteredDataSource = dataSource
        } else {
            print("Ошибка: Одно или несколько изображений не найдены")
        }

        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self

        setupSortButton()
        setupFilterButton()
    }

    private func setupSortButton() {
        let sortMenu = UIMenu(title: "Сортировка", options: .displayInline, children: [
            UIAction(title: "По названию ↑", handler: { _ in self.sortMovies(by: .titleDescending) }),
            UIAction(title: "По названию ↓", handler: { _ in self.sortMovies(by: .titleAscending) }),
            UIAction(title: "По рейтингу ↑", handler: { _ in self.sortMovies(by: .ratingAscending) }),
            UIAction(title: "По рейтингу ↓", handler: { _ in self.sortMovies(by: .ratingDescending) })
        ])
        sortButton.menu = sortMenu
        sortButton.showsMenuAsPrimaryAction = true
    }

    private func setupFilterButton() {
        let genres = Set(dataSource.flatMap { $0.genre.lowercased().components(separatedBy: "/") })
        var genreActions: [UIAction] = genres.map { genre in
            return UIAction(title: genre.capitalized, handler: { _ in self.filterMovies(by: genre) })
        }
        genreActions.append(UIAction(title: "Все жанры", handler: { _ in self.resetFilter() }))
        
        let filterMenu = UIMenu(title: "Фильтр", options: .displayInline, children: genreActions)
        filterButton.menu = filterMenu
        filterButton.showsMenuAsPrimaryAction = true
    }

    private enum SortOption {
        case titleAscending
        case titleDescending
        case ratingAscending
        case ratingDescending
    }

    private func sortMovies(by option: SortOption) {
        switch option {
        case .titleAscending:
            filteredDataSource.sort { $0.title < $1.title }
        case .titleDescending:
            filteredDataSource.sort { $0.title > $1.title }
        case .ratingAscending:
            filteredDataSource.sort { Double($0.rating)! < Double($1.rating)! }
        case .ratingDescending:
            filteredDataSource.sort { Double($0.rating)! > Double($1.rating)! }
        }
        tableView.reloadData()
    }

    private func filterMovies(by genre: String) {
        filteredDataSource = dataSource.filter { $0.genre.lowercased().components(separatedBy: "/").contains(genre.lowercased()) }
        tableView.reloadData()
    }

    private func resetFilter() {
        filteredDataSource = dataSource
        tableView.reloadData()
    }
}

extension FirstViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredDataSource = dataSource
        } else {
            filteredDataSource = dataSource.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension FirstViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell else { return UITableViewCell() }

        cell.config(user: filteredDataSource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = filteredDataSource[indexPath.row]
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailVC.movie = selectedMovie
            present(detailVC, animated: true) {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
