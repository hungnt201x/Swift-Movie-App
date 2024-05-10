import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var callAPIbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPIbtn.addTarget(self, action: #selector(getDetail), for: .touchUpInside)
        
    }
    
    @objc func getTrendingList() {
        NetworkManager.manager.getMovies { movies in
            if let movies = movies {
                if movies.isEmpty {
                    print("Không có phim nào")
                } else {
                    for movie in movies {
                        if let title = movie.title {
                            print("Phim: \(title)")
                        }
                        if let date = movie.releaseDate {
                            print("Date: \(date)")
                        }
                    }
                }
            } else {
                print("Không thể lấy danh sách phim")
            }
        }
    }
    
    @objc func getDetail() {
        NetworkManager.manager.getMovieDetail(id: "967847" ){ movieDetail in
            if let detail = movieDetail {
                print("Backdrop Path: \(detail.imageUrl ?? "N/A")")
                print("Original Title: \(detail.title ?? "N/A")")
                if let genres = detail.genres {
                    print("Genres: \(genres.map { $0.name ?? "N/A" })")
                }
                print("Vote Average: \(detail.voteAverage ?? 0)")
                print("Runtime: \(detail.runtime ?? 0)")
                print("Overview: \(detail.overview ?? "N/A")")
            } else {
                print("Không có dữ liệu chi tiết phim")
            }
        }
    }
    
}

