import UIKit
import SDWebImage
import Cosmos

class MovieDetailVC: UIViewController {
    @IBOutlet weak var posterImageVIew: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToWatchList: UIButton!
    @IBOutlet weak var cosmosView: CosmosView!
    
    var movieId: Int?
    var movieList: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        getDetail(id: movieId)
        addToWatchList.addTarget(self, action: #selector(addToWatchListButtonTapped(_:)), for: .touchUpInside)
    }
    
    func setNavigation(){
        navigationController?.navigationBar.backgroundColor = .white.withAlphaComponent(0.1)
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.isTranslucent = false
        let backButton = UIBarButtonItem()
        backButton.title = "Back to movies"
        backButton.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func getDetail(id: Int?) {
        NetworkManager.manager.getMovieDetail(id: String(movieId ?? 0) ){ movieDetail in
            if let detail = movieDetail {
                let imageloadURL = UrlSession.loadImageUrl+(detail.imageUrl ?? "")
                if let imageUrl = URL(string: imageloadURL) {
                    self.posterImageVIew.sd_setImage(with: imageUrl, placeholderImage: nil, options: [], completed: nil)
                }
                if let genres = detail.genres {
                    let genresText = genres.map { $0.name ?? "N/A" }.joined(separator: ", ")
                    self.genreLabel.text = "Genre: "+genresText
                }
                self.movieNameLabel.text = detail.title ?? "N/A"
                self.voteAverageLabel.text = String(format: "Rating: %.1f", detail.voteAverage ?? 0) + "/10"
                
                if let formattedDate = DateFormatterHelper.formatDate(from: detail.releasedDate ?? "N/A") {
                    self.releasedDateLabel.text = "Released date: "+formattedDate
                } else {
                    self.releasedDateLabel.text = "Released date: "+(detail.releasedDate ?? "N/A")
                }
                self.durationLabel.text = "Duration: "+String(detail.runtime ?? 0)+" min"
                self.descriptionLabel.text = detail.overview
                self.cosmosView.settings.updateOnTouch = false
                self.cosmosView.rating = (detail.voteAverage ?? 0)/2
                self.cosmosView.settings.fillMode = .half
            } else {
                print("No data")
            }
        }
    }
    
    @objc func addToWatchListButtonTapped(_ sender: UIButton) {
        guard let movieId = self.movieId, let movieList = self.movieList else { return }
        let selectedMovie = movieList.first(where: { $0.id == movieId })
        
        if let selectedMovie = selectedMovie {
            DBHelper.shared.addToWatchList(movie: selectedMovie)
            let alertController = UIAlertController(title: "Success", message: "The movie has been added to your watchlist.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "WatchListUpdated"), object: nil)
        }
    }
}


