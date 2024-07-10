import UIKit

struct Developer {
    var name: String
    var title: String
    var photo: UIImage?
    var email: String
}

class AboutViewController: UIViewController {
    private lazy var developersLabel : UILabel = {
           let developersLabel = UILabel()
           developersLabel.text = "Разработчики:"
           developersLabel.textColor = UIColor(named: "textcolor")
           developersLabel.font = UIFont.boldSystemFont(ofSize: 20)
           developersLabel.translatesAutoresizingMaskIntoConstraints = false
           return developersLabel
       }()
    
    private lazy var developersTableView: UITableView = {
            let table = UITableView()
            table.backgroundColor = .clear
            table.register(
                UserInfoTableViewCell.self,
                forCellReuseIdentifier: UserInfoTableViewCell.reuseIdentifier
            )
            table.rowHeight = 90
            table.showsVerticalScrollIndicator = false
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()
  
    var developers: [Developer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "О нас"
        

        developers = [
            Developer(name: "Ярослав Мидаков", title: "sickboips", photo: UIImage(named: "yarik.jpg"), email: "yaroslav@gmail.com"),
            Developer(name: "Алексей Севастьянов", title: "smeldon", photo: UIImage(named: "alex.jpg"), email: "alexey@gmail.com"),
            Developer(name: "Айнур Салахутдинов", title: "Ainur_575", photo: UIImage(named: "ain.jpg"), email: "ainur@gmail.com")
            
        ]
        developersTableView.dataSource = self
        setupLayout()
    }
    private func setupLayout() {
            
        view.addSubview(developersLabel)
        view.addSubview(developersTableView)


            NSLayoutConstraint.activate([
                developersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
                developersLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
                developersLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                
                developersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
                developersTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                developersTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                developersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
}
extension AboutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        developers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.reuseIdentifier, for: indexPath) as? UserInfoTableViewCell
        guard let cell else {return UITableViewCell()}
        cell.configure(with: developers[indexPath.row])
        return cell
    }
    
}
