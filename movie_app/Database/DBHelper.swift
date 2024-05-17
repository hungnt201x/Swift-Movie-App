import Foundation

class DBHelper {
    static let shared = DBHelper()
    
    func addToWatchList(movie: Movie) {
        var watchListMovies = UserDefaults.standard.array(forKey: "WatchListMovies") as? [[String: Any]] ?? []
        if !watchListMovies.contains(where: { $0["title"] as? String == movie.title }) {
            watchListMovies.append(["title": movie.title ?? "", "releaseDate": movie.releaseDate ?? ""])
            UserDefaults.standard.set(watchListMovies, forKey: "WatchListMovies")
        }
    }
    
    func isMovieInWatchList(movieTitle: String) -> Bool {
        let watchListMovies = UserDefaults.standard.array(forKey: "WatchListMovies") as? [[String: Any]] ?? []
        return watchListMovies.contains(where: { $0["title"] as? String == movieTitle })
    }
}
