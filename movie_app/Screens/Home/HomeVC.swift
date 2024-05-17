import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    var movieList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        getTrendingList()
        movieTableView.dataSource = self
        movieTableView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(updateWatchList), name: NSNotification.Name(rawValue: "WatchListUpdated"), object: nil)
    }
    
    func setNavigation(){
        let iconBackButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: nil)
        iconBackButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = iconBackButton
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func getTrendingList() {
        NetworkManager.manager.getMovies { movies in
            if let movies = movies {
                if movies.isEmpty {
                    print("No movies available")
                } else {
                    self.movieList = movies
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                }
            } else {
                print("Unable to fetch movie list")
            }
        }
    }
    
    @objc func updateWatchList() {
        movieTableView.reloadData()
    }
    
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let movie = movieList[indexPath.row]
        cell.movieNameLabel.text = movie.title ?? "N/A"
        
        if let formattedDate = DateFormatterHelper.formatDate(from: movie.releaseDate ?? "N/A") {
            cell.releasedDateLabel.text = formattedDate
        } else {
            cell.releasedDateLabel.text = movie.releaseDate ?? "N/A"
        }
        cell.onMyWatchlistLabel.text = ""
        let imageloadURL = UrlSession.loadImageUrl+(movie.posterPath ?? "")
        if let imageUrl = URL(string: imageloadURL) {
            cell.posterMovieImageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: [], completed: nil)
        }
        if DBHelper.shared.isMovieInWatchList(movieTitle: movie.title ?? "") {
            cell.onMyWatchlistLabel.text = "On my list"
        } else {
            cell.onMyWatchlistLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movieList[indexPath.row]
        let movieDetailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailID") as! MovieDetailVC
        movieDetailVC.movieId = selectedMovie.id
        movieDetailVC.movieList = self.movieList
        if let navController = self.navigationController {
            navController.pushViewController(movieDetailVC, animated: true)
        } else {
            print("Error: navigationController is nil.")
        }
    }
    
    
}
