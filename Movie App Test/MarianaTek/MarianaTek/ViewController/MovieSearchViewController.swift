//
//  ViewController.swift
//  MarianaTek
//

import UIKit


class MovieSearchViewController: UIViewController {
    
    private var searchController: UISearchController!
    private var viewModel: MovieViewModel!
    private var movies: [Movie] = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        DispatchQueue.main.async {
            self.showAlert(title: Constants.searchMovie, message:Constants.searchMovieMessage)
        }
    }
    private func setupViews() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        let movieService = MovieService()
        viewModel = MovieViewModel(movieService: movieService)
        searchBar.delegate = self
        moviesTableView.estimatedRowHeight = 100
    }
}
// MARK: - UITableViewDataSource
extension MovieSearchViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        showAlert(title:movie.title , message: movie.overview)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.OK, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
// MARK: - SearchBarDelegate
extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else {
            return
        }
        // Calling the searchMovies method on the movieViewModel
        viewModel.searchMovies(withQuery: searchTerm) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    if movies.count == 0 {
                        self?.showAlert(title: Constants.noMovies, message: Constants.noMovieMessage)
                    }
                    self?.movies = movies
                    self?.moviesTableView.reloadData()
                case .failure(let error):
                    self?.showAlert(title: Constants.error, message: error.localizedDescription)
                }
            }
        }
        searchBar.resignFirstResponder()
    }
}
