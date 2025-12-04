//
//  ViewController.swift
//  MovieList-iOS
//
//  Created by Mananas on 4/12/25.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var movies: [Movie] = []
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    // MARK: Business Logic
    func getMovieList (query: String) {
        var MovieResponse: MovieResponse?
        Task {
            MovieResponse = await MovieProvider.getMoviesByName(name: query)
            if (MovieResponse!.Response == "True") {
                self.movies = MovieResponse!.Search!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                showMessage(message: MovieResponse!.Error!)
            }
        }
    }
    
    // MARK: TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieViewCell
        let movie = movies[indexPath.row]
        cell.render(with: movie)
        return cell
    }
    
    // MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        Task {
            if let details = await MovieProvider.getMovieDetails(imdbID: selectedMovie.imdbID) {
                if details.Response == "True" {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "ShowMovieDetails", sender: details)
                        tableView.deselectRow(at: indexPath, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showMessage(message: details.Error!)
                        tableView.deselectRow(at: indexPath, animated: true)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showMessage(message: "Can't get movie details. Try again later.")
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            }
        }
    }
    
    // MARK: SearchBar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (((searchBar.text?.isEmpty) != nil)) {
            getMovieList(query: searchBar.text!)
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowMovieDetails",
              let detailVC = segue.destination as? DetailViewController,
              let details = sender as? MovieDetail else {
            return
        }
        detailVC.movieDetail = details
     }
}
